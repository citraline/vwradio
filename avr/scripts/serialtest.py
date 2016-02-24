#!/usr/bin/env python
import os
import sys
import time
import unittest
import serial # pyserial

CMD_SET_LED = 0x01
CMD_ECHO = 0x02
CMD_SET_RUN_MODE = 0x03
CMD_EMULATED_UPD_DUMP_STATE = 0x10
CMD_EMULATED_UPD_SEND_COMMAND = 0x11
CMD_EMULATED_UPD_RESET = 0x12
CMD_RADIO_LOAD_KEY_DATA = 0x20
CMD_FACEPLATE_UPD_DUMP_STATE = 0x30
CMD_FACEPLATE_UPD_SEND_COMMAND = 0x31
CMD_FACEPLATE_CLEAR_DISPLAY = 0x32
ACK = 0x06
NAK = 0x15
RUN_MODE_NORMAL = 0x00
RUN_MODE_TEST = 0x01
LED_GREEN = 0x00
LED_RED = 0x01
UPD_RAM_DISPLAY_DATA = 0
UPD_RAM_PICTOGRAPH = 1
UPD_RAM_CHARGEN = 2
UPD_RAM_NONE = 0xFF

class Client(object):
    def __init__(self, ser):
        self.serial = ser

    # High level

    def echo(self, data):
        rx_bytes = self.command(bytearray([CMD_ECHO]) + bytearray(data))
        return rx_bytes[1:]

    def set_run_mode(self, mode):
        self.command([CMD_SET_RUN_MODE, mode])

    def set_led(self, led_num, led_state):
        self.command([CMD_SET_LED, led_num, int(led_state)])

    def emulated_upd_reset(self):
        self.command([CMD_EMULATED_UPD_RESET])

    def _decode_state(self, raw):
        assert len(raw) == 153
        dump = {'ram_area': raw[1],
                'ram_size': raw[2],
                'address': raw[3],
                'increment': bool(raw[4]),
                'display_data_ram': raw[5:30],
                'display_data_ram_dirty': bool(raw[30]),
                'pictograph_ram': raw[31:39],
                'pictograph_ram_dirty': bool(raw[39]),
                'chargen_ram': raw[40:152],
                'chargen_ram_dirty': bool(raw[152]),
               }
        assert len(dump['display_data_ram']) == 25
        assert len(dump['pictograph_ram']) == 8
        assert len(dump['chargen_ram']) == 112
        return dump

    def emulated_upd_dump_state(self):
        raw = self.command([CMD_EMULATED_UPD_DUMP_STATE])
        return self._decode_state(raw)

    def emulated_upd_send_command(self, spi_bytes):
        data = bytearray([CMD_EMULATED_UPD_SEND_COMMAND]) + bytearray(spi_bytes)
        self.command(data)

    def radio_load_key_data(self, key_bytes):
        data = bytearray([CMD_RADIO_LOAD_KEY_DATA]) + bytearray(key_bytes)
        self.command(data)

    def faceplate_upd_send_command(self, spi_bytes):
        data = bytearray([CMD_FACEPLATE_UPD_SEND_COMMAND]) + bytearray(spi_bytes)
        self.command(data)

    def faceplate_upd_dump_state(self):
        raw = self.command([CMD_FACEPLATE_UPD_DUMP_STATE])
        return self._decode_state(raw)

    def faceplate_clear_display(self):
        self.command([CMD_FACEPLATE_CLEAR_DISPLAY])

    # Low level

    def command(self, data, ignore_nak=False):
        self.send(data)
        return self.receive(ignore_nak)

    def send(self, data):
        self.serial.write(bytearray([len(data)] + list(data)))
        self.serial.flush()

    def receive(self, ignore_nak=False):
        # read number of bytes to expect
        head = self.serial.read(1)
        if len(head) == 0:
            raise Exception("Timeout: No reply header byte received")
        expected_num_bytes = ord(head)

        # read bytes expected, or more if available
        num_bytes_to_read = expected_num_bytes
        if self.serial.in_waiting > num_bytes_to_read: # unexpected extra data
            num_bytes_to_read = self.serial.in_waiting
        rx_bytes = bytearray(self.serial.read(num_bytes_to_read))

        # sanity checks on reply length
        if len(rx_bytes) < expected_num_bytes:
            raise Exception(
                "Timeout: Expected reply of %d bytes, got only %d bytes: %r" %
                (expected_num_bytes, len(rx_bytes), rx_bytes)
                )
        elif len(rx_bytes) > expected_num_bytes:
            raise Exception(
                "Invalid: Too long: expected %d bytes, got %d bytes: %r " %
                (expected_num_bytes, len(rx_bytes), rx_bytes)
            )
        elif len(rx_bytes) == 0:
            raise Exception("Invalid: Reply had header byte but not ack/nak")

        # check ack/nak byte
        if rx_bytes[0] not in (ACK, NAK):
            raise Exception("Invalid: First byte not ACK/NAK: %r" % rx_bytes)
        elif (rx_bytes[0] == NAK) and (not ignore_nak):
            raise Exception("Received NAK response: %r" % rx_bytes)

        return rx_bytes


class AvrTests(unittest.TestCase):
    serial = None # serial.Serial instance

    def setUp(self):
        self.client = Client(self.serial)
        self.client.set_run_mode(RUN_MODE_TEST)

    def tearDown(self):
        self.client.set_run_mode(RUN_MODE_NORMAL)

    # Command timeout

    if 'ALL' in os.environ:
        def test_timeout_ignores_incomplete_command(self):
            '''this test takes 2.25 seconds'''
            # send incomplete command
            self.client.serial.write(bytearray([42, 1, 2, 3]))
            self.client.serial.flush()
            # wait longer than timeout period
            time.sleep(2.25)
            # command should have timed out
            # next command should complete successfully
            rx_bytes = self.client.command(
                data=[CMD_ECHO], ignore_nak=True)
            self.assertEqual(rx_bytes, bytearray([ACK]))

        def test_timeout_timer_resets_after_each_byte(self):
            '''this test takes 6 seconds'''
            # send individual bytes very slowly
            for b in (5,CMD_ECHO,4,3,2,1,):
                self.client.serial.write(bytearray([b]))
                self.client.serial.flush()
                time.sleep(1)
            # command should not have timed out
            rx_bytes = self.client.receive()
            self.assertEqual(rx_bytes, bytearray([ACK,4,3,2,1,]))

    # Command dispatch

    def test_dispatch_returns_nak_for_zero_length_command(self):
        rx_bytes = self.client.command(data=[], ignore_nak=True)
        self.assertEqual(rx_bytes, bytearray([NAK]))

    def test_dispatch_returns_nak_for_invalid_command(self):
        rx_bytes = self.client.command(data=[0xFF], ignore_nak=True)
        self.assertEqual(rx_bytes, bytearray([NAK]))

    # Echo command

    def test_high_level_echo(self):
        data = b'Hello world'
        self.assertEqual(self.client.echo(data), data)

    def test_echo_empty_args_returns_empty_ack(self):
        rx_bytes = self.client.command(
            data=[CMD_ECHO], ignore_nak=True)
        self.assertEqual(rx_bytes, bytearray([ACK]))

    def test_echo_returns_args(self):
        for args in ([], [1], [1, 2, 3], list(range(254))):
            rx_bytes = self.client.command(
                data=[CMD_ECHO] + args, ignore_nak=True)
            self.assertEqual(rx_bytes, bytearray([ACK] + args))

    # Set run mode command

    def test_set_run_mode_returns_nak_for_bad_args_length(self):
        for args in ([], [RUN_MODE_TEST, 1]):
            rx_bytes = self.client.command(
                data=[CMD_SET_RUN_MODE] + args, ignore_nak=True)
            self.assertEqual(rx_bytes, bytearray([NAK]))

    def test_set_run_mode_returns_nak_for_bad_mode(self):
        rx_bytes = self.client.command(
            data=[CMD_SET_RUN_MODE, 0xFF], ignore_nak=True)
        self.assertEqual(rx_bytes, bytearray([NAK]))

    # Set LED command

    def test_high_level_set_led(self):
        for led in (LED_GREEN, LED_RED):
            for state in (1, 0):
                self.client.set_led(led, state)

    def test_set_led_returns_nak_for_bad_args_length(self):
        for args in ([], [1]):
            rx_bytes = self.client.command(
                data=[CMD_SET_LED] + args, ignore_nak=True)
            self.assertEqual(rx_bytes, bytearray([NAK]))

    def test_set_led_returns_nak_for_bad_led(self):
        rx_bytes = self.client.command(
            data=[CMD_SET_LED, 0xFF, 1], ignore_nak=True)
        self.assertEqual(rx_bytes, bytearray([NAK]))

    def test_set_led_changes_valid_led(self):
        for led in (LED_GREEN, LED_RED):
            for state in (1, 0):
                rx_bytes = self.client.command(
                    data=[CMD_SET_LED, led, state], ignore_nak=True)
                self.assertEqual(rx_bytes, bytearray([ACK]))

    # Reset UPD command

    def test_emulated_upd_reset_accepts_no_args(self):
        rx_bytes = self.client.command(
            data=[CMD_EMULATED_UPD_RESET, 1], ignore_nak=True)
        self.assertEqual(rx_bytes, bytearray([NAK]))

    # Dump UPD State command

    def test_emulated_upd_dump_state_accepts_no_args(self):
        rx_bytes = self.client.command(
            data=[CMD_EMULATED_UPD_DUMP_STATE, 1], ignore_nak=True)
        self.assertEqual(rx_bytes, bytearray([NAK]))

    def test_emulated_upd_dump_state_dumps_serialized_state(self):
        rx_bytes = self.client.command(
            data=[CMD_EMULATED_UPD_DUMP_STATE], ignore_nak=True)
        self.assertEqual(rx_bytes[0], ACK)
        self.assertEqual(len(rx_bytes), 153)

    # Process UPD Command command

    def test_process_upd_cmd_allows_empty_spi_data(self):
        self.client.emulated_upd_reset()
        rx_bytes = self.client.command(
            data=[CMD_EMULATED_UPD_SEND_COMMAND] + [], ignore_nak=True)
        self.assertEqual(rx_bytes[0], ACK)
        self.assertEqual(len(rx_bytes), 1)

    def test_process_upd_cmd_allows_max_spi_data_size_of_32(self):
        self.client.emulated_upd_reset()
        rx_bytes = self.client.command(
            data=[CMD_EMULATED_UPD_SEND_COMMAND] + ([0] * 32), ignore_nak=True)
        self.assertEqual(rx_bytes[0], ACK)
        self.assertEqual(len(rx_bytes), 1)

    def test_process_upd_cmd_returns_nak_if_spi_data_size_exceeds_32(self):
        self.client.emulated_upd_reset()
        rx_bytes = self.client.command(
            data=[CMD_EMULATED_UPD_SEND_COMMAND] + ([0] * 33),
            ignore_nak=True
            )
        self.assertEqual(rx_bytes[0], NAK)
        self.assertEqual(len(rx_bytes), 1)

    # uPD16432B Emulator

    def test_upd_resets_to_known_state(self):
        self.client.emulated_upd_reset()
        state = self.client.emulated_upd_dump_state()
        self.assertEqual(state['ram_area'], UPD_RAM_NONE) # 0=none
        self.assertEqual(state['ram_size'], 0)
        self.assertEqual(state['address'], 0)
        self.assertEqual(state['increment'], False)
        self.assertEqual(state['display_data_ram'], bytearray([0]*25))
        self.assertEqual(state['chargen_ram'], bytearray([0]*112))
        self.assertEqual(state['pictograph_ram'], bytearray([0]*8))

    # uPD16432B Emulator: Data Setting Command

    def test_upd_data_setting_sets_display_data_ram_area_increment_off(self):
        self.client.emulated_upd_reset()
        cmd  = 0b01000000 # data setting command
        cmd |= 0b00000000 # display data ram
        cmd |= 0b00001000 # increment off
        self.client.emulated_upd_send_command([cmd])
        state = self.client.emulated_upd_dump_state()
        self.assertEqual(state['ram_area'], UPD_RAM_DISPLAY_DATA)
        self.assertEqual(state['ram_size'], 25)
        self.assertEqual(state['increment'], False)

    def test_upd_data_setting_sets_display_data_ram_area_increment_on(self):
        self.client.emulated_upd_reset()
        cmd  = 0b01000000 # data setting command
        cmd |= 0b00000000 # display data ram
        cmd |= 0b00000000 # increment on
        self.client.emulated_upd_send_command([cmd])
        state = self.client.emulated_upd_dump_state()
        self.assertEqual(state['ram_area'], UPD_RAM_DISPLAY_DATA)
        self.assertEqual(state['ram_size'], 25)
        self.assertEqual(state['increment'], True)

    def test_upd_data_setting_sets_pictograph_ram_area_increment_off(self):
        self.client.emulated_upd_reset()
        cmd  = 0b01000000 # data setting command
        cmd |= 0b00000001 # pictograph ram
        cmd |= 0b00001000 # increment off
        self.client.emulated_upd_send_command([cmd])
        state = self.client.emulated_upd_dump_state()
        self.assertEqual(state['ram_area'], UPD_RAM_PICTOGRAPH)
        self.assertEqual(state['ram_size'], 8)
        self.assertEqual(state['increment'], False)

    def test_upd_data_setting_sets_chargen_ram_area_increment_on(self):
        self.client.emulated_upd_reset()
        cmd  = 0b01000000 # data setting command
        cmd |= 0b00000010 # chargen ram
        cmd |= 0b00000000 # increment on
        self.client.emulated_upd_send_command([cmd])
        state = self.client.emulated_upd_dump_state()
        self.assertEqual(state['ram_area'], UPD_RAM_CHARGEN)
        self.assertEqual(state['ram_size'], 112)
        self.assertEqual(state['increment'], True)

    def test_upd_data_setting_sets_chargen_ram_area_ignores_increment_off(self):
        self.client.emulated_upd_reset()
        cmd  = 0b01000000 # data setting command
        cmd |= 0b00000010 # chargen ram
        cmd |= 0b00001000 # increment off (should be ignored)
        self.client.emulated_upd_send_command([cmd])
        state = self.client.emulated_upd_dump_state()
        self.assertEqual(state['ram_area'], UPD_RAM_CHARGEN)
        self.assertEqual(state['ram_size'], 112)
        self.assertEqual(state['increment'], True)

    def test_upd_data_setting_unrecognized_ram_area_sets_none(self):

        self.client.emulated_upd_reset()
        cmd  = 0b01000000 # data setting command
        cmd |= 0b00000111 # not a valid ram area
        self.client.emulated_upd_send_command([cmd])
        state = self.client.emulated_upd_dump_state()
        self.assertEqual(state['ram_area'], UPD_RAM_NONE)
        self.assertEqual(state['ram_size'], 0)
        self.assertEqual(state['address'], 0)
        self.assertEqual(state['increment'], True)

    def test_upd_data_setting_unrecognized_ram_area_ignores_increment_off(self):
        self.client.emulated_upd_reset()
        cmd  = 0b01000000 # data setting command
        cmd |= 0b00000111 # not a valid ram area
        cmd |= 0b00001000 # increment off (should be ignored)
        self.client.emulated_upd_send_command([cmd])
        state = self.client.emulated_upd_dump_state()
        self.assertEqual(state['ram_area'], UPD_RAM_NONE)
        self.assertEqual(state['ram_size'], 0)
        self.assertEqual(state['address'], 0)
        self.assertEqual(state['increment'], True)

    # uPD16432B Emulator: Address Setting Command

    def test_upd_address_setting_unrecognized_ram_area_sets_zero(self):
        self.client.emulated_upd_reset()
        state = self.client.emulated_upd_dump_state()
        self.assertEqual(state['ram_area'], UPD_RAM_NONE)
        cmd  = 0b10000000 # address setting command
        cmd |= 0b00000011 # address 0x03
        self.client.emulated_upd_send_command([cmd])
        state = self.client.emulated_upd_dump_state()
        self.assertEqual(state['address'], 0)

    def test_upd_address_setting_sets_addresses_for_each_ram_area(self):
        tuples = (
            (UPD_RAM_DISPLAY_DATA, 0b00000000, 0,       0), # min
            (UPD_RAM_DISPLAY_DATA, 0b00000000, 0x18, 0x18), # max
            (UPD_RAM_DISPLAY_DATA, 0b00000000, 0x19,    0), # out of range

            (UPD_RAM_PICTOGRAPH,   0b00000001,    0,    0), # min
            (UPD_RAM_PICTOGRAPH,   0b00000001, 0x07, 0x07), # max
            (UPD_RAM_PICTOGRAPH,   0b00000001, 0x08,    0), # out of range

            (UPD_RAM_CHARGEN,      0b00000010,    0,    0), # min
            (UPD_RAM_CHARGEN,      0b00000010, 0x0f, 0x69), # max
            (UPD_RAM_CHARGEN,      0b00000010, 0x10,    0), # out of range
        )
        for ram_area, ram_select_bits, address, expected_address in tuples:
            self.client.emulated_upd_reset()
            # data setting command
            cmd  = 0b01000000 # data setting command
            cmd |= ram_select_bits
            self.client.emulated_upd_send_command([cmd])
            state = self.client.emulated_upd_dump_state()
            self.assertEqual(state['ram_area'], ram_area)
            # address setting command
            cmd = 0b10000000
            cmd |= address
            self.client.emulated_upd_send_command([cmd])
            # address should be as expected
            state = self.client.emulated_upd_dump_state()
            self.assertEqual(state['address'], expected_address)

    # uPD16432B Emulator: Writing Data

    def test_upd_no_ram_area_ignores_data(self):
        self.client.emulated_upd_reset()
        state = self.client.emulated_upd_dump_state()
        # address setting command
        # followed by bytes that should be ignored
        cmd = 0b10000000
        cmd |= 0 # address 0
        data = bytearray(range(1, 8))
        self.client.emulated_upd_send_command(bytearray([cmd]) + data)
        self.assertEqual(self.client.emulated_upd_dump_state(), state)

    def test_upd_display_data_increment_on_writes_data(self):
        self.client.emulated_upd_reset()
        # data setting command
        cmd  = 0b01000000 # data setting command
        cmd |= 0b00000000 # display data ram
        cmd |= 0b00000000 # increment on
        self.client.emulated_upd_send_command([cmd])
        # address setting command
        # followed by a unique byte for all 25 bytes of display data ram
        cmd = 0b10000000
        cmd |= 0 # address 0
        data = bytearray(range(1, 26))
        self.client.emulated_upd_send_command(bytearray([cmd]) + data)
        state = self.client.emulated_upd_dump_state()
        self.assertEqual(state['ram_area'], UPD_RAM_DISPLAY_DATA)
        self.assertEqual(state['increment'], True)
        self.assertEqual(state['address'], 0) # wrapped around
        self.assertEqual(state['display_data_ram'], data)

    def test_upd_display_data_increment_off_rewrites_data(self):
        self.client.emulated_upd_reset()
        # data setting command
        cmd  = 0b01000000 # data setting command
        cmd |= 0b00000000 # display data ram
        cmd |= 0b00001000 # increment off
        self.client.emulated_upd_send_command([cmd])
        # address setting command
        cmd = 0b10000000
        cmd |= 5 # address 5
        # address setting command
        # followed by bytes that should be written to address 5 only
        self.client.emulated_upd_send_command([cmd, 1, 2, 3, 4, 5, 6, 7])
        state = self.client.emulated_upd_dump_state()
        self.assertEqual(state['ram_area'], UPD_RAM_DISPLAY_DATA)
        self.assertEqual(state['increment'], False)
        self.assertEqual(state['address'], 5)
        self.assertEqual(state['display_data_ram'][5], 7)

    # uPD16432B Emulator: Dirty RAM Tracking

    def test_upd_writing_display_data_ram_same_value_doesnt_set_dirty(self):
        self.client.emulated_upd_reset()
        state = self.client.emulated_upd_dump_state()
        self.assertFalse(state['display_data_ram_dirty'])
        self.assertEqual(state['display_data_ram'][0], 0)
        # send data setting command
        cmd  = 0b01000000 # data setting command
        cmd |= 0b00000000 # display data ram
        cmd |= 0b00001000 # increment off
        self.client.emulated_upd_send_command([cmd])
        # send address setting command followed by same value
        cmd = 0b10000000
        cmd |= 0 # address 0
        self.client.emulated_upd_send_command([cmd, 0])
        # dirty flag should still be false
        state = self.client.emulated_upd_dump_state()
        self.assertFalse(state['display_data_ram_dirty'])

    def test_upd_writing_display_data_ram_new_value_sets_dirty(self):
        self.client.emulated_upd_reset()
        state = self.client.emulated_upd_dump_state()
        self.assertFalse(state['display_data_ram_dirty'])
        self.assertEqual(state['display_data_ram'][0], 0)
        # send data setting command
        cmd  = 0b01000000 # data setting command
        cmd |= 0b00000000 # display data ram
        cmd |= 0b00001000 # increment off
        self.client.emulated_upd_send_command([cmd])
        # send address setting command followed by same value
        cmd = 0b10000000
        cmd |= 0 # address 0
        self.client.emulated_upd_send_command([cmd, 1])
        # dirty flag should be true
        state = self.client.emulated_upd_dump_state()
        self.assertEqual(state['display_data_ram'][0], 1)
        self.assertTrue(state['display_data_ram_dirty'])

    def test_upd_writing_pictograph_ram_same_value_doesnt_set_dirty(self):
        self.client.emulated_upd_reset()
        state = self.client.emulated_upd_dump_state()
        self.assertFalse(state['pictograph_ram_dirty'])
        self.assertEqual(state['pictograph_ram'][0], 0)
        # send data setting command
        cmd  = 0b01000000 # data setting command
        cmd |= 0b00000001 # pictograph ram
        cmd |= 0b00001000 # increment off
        self.client.emulated_upd_send_command([cmd])
        # send address setting command followed by same value
        cmd = 0b10000000
        cmd |= 0 # address 0
        self.client.emulated_upd_send_command([cmd, 0])
        # dirty flag should still be false
        state = self.client.emulated_upd_dump_state()
        self.assertFalse(state['pictograph_ram_dirty'])

    def test_upd_writing_pictograph_ram_new_value_sets_dirty(self):
        self.client.emulated_upd_reset()
        state = self.client.emulated_upd_dump_state()
        self.assertFalse(state['pictograph_ram_dirty'])
        self.assertEqual(state['pictograph_ram'][0], 0)
        # send data setting command
        cmd  = 0b01000000 # data setting command
        cmd |= 0b00000001 # pictograph ram
        cmd |= 0b00001000 # increment off
        self.client.emulated_upd_send_command([cmd])
        # send address setting command followed by same value
        cmd = 0b10000000
        cmd |= 0 # address 0
        self.client.emulated_upd_send_command([cmd, 1])
        # dirty flag should be true
        state = self.client.emulated_upd_dump_state()
        self.assertEqual(state['pictograph_ram'][0], 1)
        self.assertTrue(state['pictograph_ram_dirty'])

    def test_upd_writing_chargen_ram_same_value_doesnt_set_dirty(self):
        self.client.emulated_upd_reset()
        state = self.client.emulated_upd_dump_state()
        self.assertFalse(state['chargen_ram_dirty'])
        self.assertEqual(state['chargen_ram'][0], 0)
        # send data setting command
        cmd  = 0b01000000 # data setting command
        cmd |= 0b00000010 # chargen ram
        cmd |= 0b00001000 # increment off
        self.client.emulated_upd_send_command([cmd])
        # send address setting command followed by same value
        cmd = 0b10000000
        cmd |= 0 # address 0
        self.client.emulated_upd_send_command([cmd, 0])
        # dirty flag should still be false
        state = self.client.emulated_upd_dump_state()
        self.assertFalse(state['chargen_ram_dirty'])

    def test_upd_writing_chargen_ram_new_value_sets_dirty(self):
        self.client.emulated_upd_reset()
        state = self.client.emulated_upd_dump_state()
        self.assertFalse(state['chargen_ram_dirty'])
        self.assertEqual(state['chargen_ram'][0], 0)
        # send data setting command
        cmd  = 0b01000000 # data setting command
        cmd |= 0b00000010 # chargen ram
        cmd |= 0b00001000 # increment off
        self.client.emulated_upd_send_command([cmd])
        # send address setting command followed by same value
        cmd = 0b10000000
        cmd |= 0 # address 0
        self.client.emulated_upd_send_command([cmd, 1])
        # dirty flag should be true
        state = self.client.emulated_upd_dump_state()
        self.assertEqual(state['chargen_ram'][0], 1)
        self.assertTrue(state['chargen_ram_dirty'])

    # Faceplate

    def test_faceplate_clear_display_returns_nak_for_bad_args_length(self):
        rx_bytes = self.client.command(
            data=[CMD_FACEPLATE_CLEAR_DISPLAY, 1], ignore_nak=True)
        self.assertEqual(rx_bytes, bytearray([NAK]))

    def test_faceplate_clear_display(self):
        self.client.faceplate_clear_display() # shouldn't raise

    def test_faceplate_upd_send_command_allows_max_spi_data_size_of_32(self):
        rx_bytes = self.client.command(
            data=[CMD_FACEPLATE_UPD_SEND_COMMAND] + [0x80] + ([0] * 31),
            ignore_nak=True
            )
        self.assertEqual(rx_bytes[0], ACK)
        self.assertEqual(len(rx_bytes), 1)

    def test_faceplate_upd_send_command_nak_if_spi_data_size_exceeds_32(self):
        rx_bytes = self.client.command(
            data=[CMD_FACEPLATE_UPD_SEND_COMMAND] + ([0] * 33),
            ignore_nak=True
            )
        self.assertEqual(rx_bytes[0], NAK)
        self.assertEqual(len(rx_bytes), 1)

    def test_faceplate_upd_send_command(self):
        # Data Setting command: write to display data ram
        data = [0x40]
        self.client.faceplate_upd_send_command(data) # shouldn't raise
        # Address Setting command + display data
        data = [0x80, 0, 0, 0x6f, 0x6c, 0x6c, 0x65, 0x48]
        self.client.faceplate_upd_send_command(data) # shouldn't raise

def make_serial():
    from serial.tools.list_ports import comports
    names = [ x.device for x in comports() if 'Bluetooth' not in x.device ]
    if not names:
        raise Exception("No serial port found")
    return serial.Serial(port=names[0], baudrate=115200, timeout=2)

def make_client(serial=None):
    if serial is None:
        serial = make_serial()
    return Client(serial)

def test_suite():
    return unittest.findTestCases(sys.modules[__name__])

def main(verbosity):
    AvrTests.serial = make_serial()
    unittest.main(defaultTest='test_suite', verbosity=verbosity)

if __name__ == '__main__':
    if 'VERBOSE' in os.environ:
        verbosity = 2 # test names
    else:
        verbosity = 1 # dots only
    main(verbosity)

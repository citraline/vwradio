/* ...
 * Pin  3: PB2 STB in from radio
 * Pin  4: PB3 /SS out (software generated from STB, connect to PB4)
 * Pin  5: PB4 /SS in (connect to PB3)
 * Pin  6: PB5 MOSI in (to radio's DAT)
 * Pin  7: PB6 MISO out (connect to PB5 through 10K resistor)
 * pin  8: PB7 SCK in from radio
 * pin  9: /RESET to GND through pushbutton, 10K pullup to Vcc
 * pin 10: Vcc (connect to unswitched 5V)
 * Pin 11: GND (connect to radio's GND)
 * Pin 12: XTAL2 (to 20 MHz crystal)
 * Pin 13: XTAL1 (to 20 MHz crystal)
 * Pin 14: PD0/RXD (to PC's serial TXD)
 * Pin 15: PD1/TXD (to PC's serial RXD)
 * Pin 16: PD2/RXD1 MISO in (from faceplate's DAT)
 * Pin 17: PD3/TXD1 MOSI out (to faceplate's DAT through 10K resistor)
 * Pin 18: PD4/XCK1 SCK out (to faceplate's CLK)
 * Pin 19: PD5 Green LED
 * Pin 20: PD6 Red LED
 * Pin 21: PD7 STB out to faceplate
 * ...
 * Pin 24: PC2 TCK (to JTAG)
 * Pin 25: PC3 TMS (to JTAG)
 * Pin 26: PC4 TDO (to JTAG)
 * Pin 27: PC5 TDI (to JTAG)
 * ...
 * Pin 31: GND
 * ...
 *
 * Pin assignment needed:
 *  - LOF from radio
 *  - BUS from faceplate
 *  - BUS to radio
 *  - !POWER_EJECT
 *  - EJECT
 *
 * Consider reassigning pins:
 *  - Move Green LED and Red LED somewhere else so all faceplate signals
 *    can be grouped together
 */

#include "main.h"

#include <stdint.h>
#include <avr/io.h>
#include <avr/interrupt.h>

#include "cmd.h"
#include "convert.h"
#include "faceplate.h"
#include "leds.h"
#include "radio_spi.h"
#include "radio_state.h"
#include "uart.h"
#include "updemu.h"

/* Blink red forever if an unhandled interrupt occurs.
 * This code should never been called.
 */
ISR(BADISR_vect)
{
    led_fatal(LED_CODE_BADISR);
}

/*************************************************************************
 * Main
 *************************************************************************/

int main()
{
    radio_model = RADIO_MODEL_PREMIUM_4;
    run_mode = RUN_MODE_RUNNING;
    auto_display_passthru = 1;
    auto_key_passthru = 1;

    led_init();
    uart_init();
    cmd_init();
    radio_spi_init();
    faceplate_spi_init();
    upd_init(&emulated_upd_state);
    upd_init(&faceplate_upd_state);
    sei();

    faceplate_clear_display();

    while (1)
    {
        // service bytes from uart
        if (buf_has_byte(&uart_rx_buffer))
        {
            uint8_t c;
            c = buf_read_byte(&uart_rx_buffer);
            cmd_receive_byte(c);
        }

        if (run_mode == RUN_MODE_STOPPED)
        {
            continue;
        }

        if (auto_key_passthru)
        {
            // read keys from faceplate and send to radio
            faceplate_read_key_data(upd_tx_key_data);
        }

        // process a command from the radio if one is available
        if (upd_rx_buf.read_index != upd_rx_buf.write_index)
        {
            upd_command_t cmd;
            cmd = upd_rx_buf.cmds[upd_rx_buf.read_index];
            upd_rx_buf.read_index++;

            upd_process_command(&emulated_upd_state, &cmd);
        }

        // update radio state and faceplate as needed
        radio_state_update_from_upd_if_dirty(&radio_state, &emulated_upd_state);
        if (auto_display_passthru)
        {
            faceplate_update_from_upd_if_dirty(&emulated_upd_state);
        }

        // clear dirty state for next time
        emulated_upd_state.dirty_flags = UPD_DIRTY_NONE;
    }
}

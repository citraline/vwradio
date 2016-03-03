#ifndef CMD_H
#define CMD_H

#include "updemu.h"

#define ACK 0x06
#define NAK 0x15

#define CMD_SET_LED 0x01
#define CMD_ECHO 0x02
#define CMD_SET_RUN_MODE 0x03
#define CMD_PASS_EMULATED_UPD_DISPLAY_TO_FACEPLATE 0x04
#define CMD_PASS_FACEPLATE_KEYS_TO_EMULATED_UPD 0x05

#define CMD_EMULATED_UPD_DUMP_STATE 0x10
#define CMD_EMULATED_UPD_SEND_COMMAND 0x11
#define CMD_EMULATED_UPD_RESET 0x12
#define CMD_EMULATED_UPD_LOAD_KEY_DATA 0x13

#define CMD_RADIO_STATE_PROCESS 0x21
#define CMD_RADIO_STATE_DUMP 0x22
#define CMD_RADIO_STATE_RESET 0x23

#define CMD_FACEPLATE_UPD_DUMP_STATE 0x30
#define CMD_FACEPLATE_UPD_SEND_COMMAND 0x31
#define CMD_FACEPLATE_UPD_CLEAR_DISPLAY 0x32
#define CMD_FACEPLATE_UPD_READ_KEY_DATA 0x33

#define CMD_ARG_GREEN_LED 0x00
#define CMD_ARG_RED_LED 0x01

uint8_t cmd_buf[256];
uint8_t cmd_buf_index;
uint8_t cmd_expected_length;

void cmd_init();
void cmd_receive_byte(uint8_t c);

#endif


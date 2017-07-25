#CEU_DIR  = $(error set absolute path to "<ceu>" repository)
CEU_DIR  = /data/ceu/ceu
CEU_SRC ?= samples/blink-01.ceu
CEU_ISR ?= false

INO_SRC ?= env/env.ino

#ARD_EXE = arduino
ARD_EXE   = /opt/arduino-1.8.1/arduino
ARD_ARCH  = avr
ARD_BOARD = uno
ARD_PORT  = /dev/ttyACM*
#ARD_BOARD = nano:cpu=atmega328
#ARD_BOARD = mega
#ARD_BOARD = lilypad328
#ARD_BOARD = Microduino
#ARD_BOARD = 644pa16m
#ARD_CPU = :cpu=atmega168

PRESERVE = --preserve-temp-files

all: ceu c

c:
	$(ARD_EXE) --verbose $(PRESERVE)                                \
	           --board arduino:$(ARD_ARCH):$(ARD_BOARD)$(ARD_CPU)   \
	           --port $(ARD_PORT)                                   \
	           --upload $(INO_SRC)

ceu:
	ceu --pre --pre-args="-I$(CEU_DIR)/include -I./include"         \
	          --pre-input=$(CEU_SRC)                                \
	    --ceu --ceu-err-unused=pass --ceu-err-uninitialized=pass    \
	          --ceu-features-lua=false --ceu-features-thread=false  \
	          --ceu-features-isr=$(CEU_ISR)                         \
	    --env --env-types=env/types.h                               \
	          --env-output=env/_ceu_app.c.h

.PHONY: all ceu

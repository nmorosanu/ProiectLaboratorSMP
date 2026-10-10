CC 		= 	sdcc
CFLAGS 	= 	-mmcs51 --model-small
AS 		= 	sdas8051
ASFLAGS = 	-plosgff
LD		=	sdld
LDFLAGS =	-i

DIR_SRC		= src
DIR_DEBUG	= debug
DIR_BUILD	= build
DIR_OBJ 	= $(DIR_BUILD)/obj
DIR_BIN 	= $(DIR_BUILD)/bin

C_SRCS = $(shell find $(DIR_SRC) -type f -name "*.c")
ASM_SRCS = $(shell find $(DIR_SRC) -type f -name "*.s")
C_OBJS = $(patsubst $(DIR_SRC)/%.c, $(DIR_OBJ)/%.c.rel, $(C_SRCS))
ASM_OBJS = $(patsubst $(DIR_SRC)/%.s, $(DIR_OBJ)/%.s.rel, $(ASM_SRCS))

OBJS = \
	   $(ASM_OBJS)\
	   $(C_OBJS)

FIRMWARE = firmware

all: $(FIRMWARE)

$(FIRMWARE): $(OBJS)
	@mkdir -p $(DIR_BIN)
	@echo "[LD] Linking $< into $@"
	$(LD)\
		$(LDFLAGS)\
		$(DIR_BIN)/$(FIRMWARE).ihx $(OBJS)

	packihx $(DIR_BIN)/$(FIRMWARE).ihx > $(DIR_BIN)/$(FIRMWARE).hex

$(DIR_OBJ)/%.c.rel: $(DIR_SRC)/%.c
	@mkdir -p $(DIR_OBJ)
	@echo "[CC] Compiling $< into $@"
	$(CC)\
		$(CFLAGS)\
		-o $@\
		-c $<

$(DIR_OBJ)/%.s.rel: $(DIR_SRC)/%.s
	@mkdir -p $(DIR_OBJ)
	@echo "[AS] Assembling $< into $@"
	$(AS)\
		$(ASFLAGS)\
		-o $@\
		$<

ru:	$(FIRMWARE)
	@echo "[minipro] Writting firmware"
	minipro -p AT89C51RC@DIP40 -w $(DIR_BIN)/$(FIRMWARE).hex

rd:	$(FIRMWARE)
	@echo "[minipro] Dumping firmware"
	minipro -p AT89C51RC@DIP40 -r $(DIR_DEBUG)/$(FIRMWARE).dump

.PHONY: clr
clr:
	rm -rf $(DIR_BUILD) $(DIR_DEBUG)

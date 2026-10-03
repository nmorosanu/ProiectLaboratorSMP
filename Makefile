CC 		= sdcc
CFLAGS 	= -mmcs51 --model-small
AS 		= sdas8051
ASFLAGS = -plosgff

DIR_SRC		= src
DIR_DEBUG	= debug
DIR_BUILD	= build
DIR_OBJ 	= $(DIR_BUILD)/obj
DIR_BIN 	= $(DIR_BUILD)/bin

C_SRCS = $(shell find $(DIR_SRC) -type f -name "*.c")
ASM_SRCS = $(shell find $(DIR_SRC) -type f -name "*.s")
C_OBJS = $(patsubst $(DIR_SRC)/%.c, $(DIR_OBJ)/%.c.rel, $(C_SRCS))
ASM_OBJS = $(patsubst $(DIR_SRC)/%.s, $(DIR_OBJ)/%.s.rel, $(ASM_SRCS))

OBJS = $(C_OBJS)\
	   $(ASM_OBJS)

FIRMWARE = firmware

all: $(FIRMWARE)

$(FIRMWARE): $(OBJS)
	@mkdir -p $(DIR_BIN)
	@echo "[LD] Linking $< into $@"
	$(CC)\
		$(CFLAGS)\
		-o $(DIR_BIN)/$@.ihx\
		$(OBJS)
	packihx $(DIR_BIN)/$@.ihx > $(DIR_BIN)/$@.hex
		

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

.PHONY: clr
clr:
	rm -rf $(DIR_BUILD) $(DIR_DEBUG)

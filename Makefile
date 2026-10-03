SRC_DIR   	:= src
BUILD_DIR 	:= build
DEBUG_DIR 	:= debug

AS 			:= asem

MAIN		:= main
PROGRAM 	:= $(SRC_DIR)/$(MAIN).asm
HEX 		:= $(BUILD_DIR)/$(MAIN).hex
LST 		:= $(DEBUG_DIR)/$(MAIN).lst

.PHONY: all
all: dirs $(HEX)


$(HEX): dirs $(SRC)
	@echo "[Assembling]"
	@cd $(BUILD_DIR)
	$(AS) -i $(SRC_DIR) $(PROGRAM) $(HEX) $(LST)

.PHONY: dirs
dirs:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(DEBUG_DIR)

.PHONY: clr
clr:
	@rm -rf $(BUILD_DIR)/*
	@rm -rf $(DEBUG_DIR)/*

.PHONY: rebuild
rebuild: clean all

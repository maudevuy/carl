# Carl OS Makefile
# Compile the kernel for x86_64 UEFI/BIOS with GRUB2

# ============================================================================
# Variables
# ============================================================================

CC = gcc
AS = as
LD = ld
GRUB_MKRESCUE = grub-mkrescue

# Compilation flags
CFLAGS = -ffreestanding -fno-stack-protector -fno-builtin \
         -m64 -Wall -Wextra -Iinclude -Iinclude/carl
ASFLAGS = -x assembler-with-cpp
LDFLAGS = -m elf_x86_64 -nostdlib -e _start

# Directories
BUILD_DIR = build
ISO_DIR = $(BUILD_DIR)/iso
ISODIR_BOOT = $(ISO_DIR)/boot
ISODIR_BOOT_GRUB = $(ISODIR_BOOT)/grub

# Source files
C_SOURCES = init/main.c kernel/console.c kernel/error.c kernel/util.c kernel/video_fbuf.c kernel/keyboard.c kernel/serial.c kernel/stubs.c mm/memory.c
ASM_SOURCES = boot/multiboot2.s boot/head.s mm/page.S

# Object files
C_OBJECTS = $(C_SOURCES:%.c=$(BUILD_DIR)/%.o)
ASM_OBJECTS = $(ASM_SOURCES:%.s=$(BUILD_DIR)/%.o)
ASM_OBJECTS := $(ASM_OBJECTS:%.S=$(BUILD_DIR)/%.o)

# Final binaries
KERNEL_BIN = $(BUILD_DIR)/carl.bin
ISO_OUTPUT = $(BUILD_DIR)/carl.iso

# ============================================================================
# Targets
# ============================================================================

all: $(ISO_OUTPUT)
	@echo "[OK] Carl OS ISO creado: $(ISO_OUTPUT)"
	@echo "Usa: make run"

# Execution target in QEMU
run: $(ISO_OUTPUT)
	@echo "Iniciando QEMU..."
	@echo "Tip: En GRUB, presiona ENTER para bootear Carl"
	@echo "Tip: Para cerrar, presiona Ctrl+A C y luego 'quit'"
	@echo "---"
	qemu-system-x86_64 -cdrom $(ISO_OUTPUT) -boot d -m 512M -nographic

debug: $(ISO_OUTPUT)
	qemu-system-x86_64 -cdrom $(ISO_OUTPUT) -boot d -m 512M -nographic -s -S

# Create the ISO image
$(ISO_OUTPUT): $(KERNEL_BIN) $(ISO_DIR)/boot/grub/grub.cfg
	@mkdir -p $(ISODIR_BOOT_GRUB)
	@cp $(KERNEL_BIN) $(ISODIR_BOOT)/carl.bin
	@cp boot/grub/grub.cfg $(ISODIR_BOOT_GRUB)/grub.cfg
	@$(GRUB_MKRESCUE) -o $(ISO_OUTPUT) $(ISO_DIR)
	@echo "[OK] ISO creada: $@"

# Copy GRUB configuration
$(ISO_DIR)/boot/grub/grub.cfg: boot/grub/grub.cfg
	@mkdir -p $(@D)
	@cp boot/grub/grub.cfg $@

# Linkear kernel
$(KERNEL_BIN): $(C_OBJECTS) $(ASM_OBJECTS) | $(BUILD_DIR)
	@echo "[LINK] Creando kernel: $@"
	@$(LD) $(LDFLAGS) -Ttext 0x100000 -o $@ $(ASM_OBJECTS) $(C_OBJECTS) \
	    -Tdata 0x200000
	@echo "[OK] Kernel creado: $@"

# Compile files C
$(BUILD_DIR)/%.o: %.c | $(BUILD_DIR)
	@mkdir -p $(@D)
	@echo "[CC] Compilando: $<"
	@$(CC) $(CFLAGS) -c $< -o $@

# Compile files Assembly (.s)
$(BUILD_DIR)/%.o: %.s | $(BUILD_DIR)
	@mkdir -p $(@D)
	@echo "[AS] Ensamblando: $<"
	@$(CC) $(CFLAGS) -x assembler -c $< -o $@

# Compile files Assembly (.S)
$(BUILD_DIR)/%.o: %.S | $(BUILD_DIR)
	@mkdir -p $(@D)
	@echo "[AS] Ensamblando: $<"
	@$(CC) $(CFLAGS) -x assembler -c $< -o $@

# Crear directorio de build
$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# Clean
clean:
	@echo "[CLEAN] Deleting build..."
	@rm -rf $(BUILD_DIR)

# Distclean
distclean: clean
	@echo "[DISTCLEAN] Complete Cleaning"

.PHONY: all run debug clean distclean

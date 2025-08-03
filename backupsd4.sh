#!/system/bin/sh

echo "=== TWRP Device Nodes and Runtime System Backup ==="
echo "Starting backup process..."

# Check if SD card is mounted
if [ ! -d "/external_sd" ]; then
    echo "ERROR: SD card not mounted at /external_sd"
    echo "Please mount your SD card first"
    exit 1
fi

# Create/use backup directory
BACKUP_DIR="/external_sd/TWRP_DEVICE_BACKUP"
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to create backup directory"
        exit 1
    fi
    echo "Created backup directory: $BACKUP_DIR"
else
    echo "Using existing backup directory: $BACKUP_DIR"
fi

# Initialize log files
DEVICE_LOG="$BACKUP_DIR/device_inventory.txt"
SUMMARY_LOG="$BACKUP_DIR/backup_summary.txt"

# Clear previous log files
> "$DEVICE_LOG"
> "$SUMMARY_LOG"

echo "Log files created:"
echo "- Device inventory: $DEVICE_LOG"
echo "- Backup summary: $SUMMARY_LOG"
echo ""

# Function to extract device information
extract_device_info() {
    device_path="$1"
    category="$2"
    output_file="$3"
    
    if [ -e "$device_path" ]; then
        echo "Processing: $device_path"
        
        # Get device statistics using stat
        device_type=$(stat -c "%F" "$device_path" 2>/dev/null)
        major_minor=$(stat -c "%t %T" "$device_path" 2>/dev/null)
        permissions=$(stat -c "%a" "$device_path" 2>/dev/null)
        
        # Get SELinux context
        selinux_info=$(ls -Z "$device_path" 2>/dev/null | awk '{print $1}')
        
        # Write to category file and main inventory
        echo "$device_path|$device_type|$major_minor|$permissions|$selinux_info" >> "$output_file"
        echo "$device_path|$device_type|$major_minor|$permissions|$selinux_info" >> "$DEVICE_LOG"
        
        echo "  Added to inventory: $device_path"
    else
        echo "  SKIP: $device_path (doesn't exist)"
    fi
}

# Function to copy runtime information files
copy_runtime_info() {
    src_file="$1"
    dst_file="$2"
    description="$3"
    
    if [ -f "$src_file" ]; then
        echo "Copying: $description"
        cp "$src_file" "$dst_file" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "  SUCCESS: $description copied"
        else
            echo "  FAILED: Could not copy $description"
        fi
    else
        echo "  SKIP: $src_file not found"
    fi
}

# Create device categories directories
DEV_CATEGORIES="$BACKUP_DIR/device_categories"
RUNTIME_INFO="$BACKUP_DIR/runtime_info"
SELINUX_INFO="$BACKUP_DIR/selinux_info"

mkdir -p "$DEV_CATEGORIES"
mkdir -p "$RUNTIME_INFO" 
mkdir -p "$SELINUX_INFO"

echo "========================================"
echo "PHASE 1: Extracting Device Nodes"
echo "========================================"

# Initialize category files
AUDIO_DEVICES="$DEV_CATEGORIES/audio_devices.txt"
BLOCK_DEVICES="$DEV_CATEGORIES/block_devices.txt"
INPUT_DEVICES="$DEV_CATEGORIES/input_devices.txt"
SYSTEM_DEVICES="$DEV_CATEGORIES/system_devices.txt"
GRAPHICS_DEVICES="$DEV_CATEGORIES/graphics_devices.txt"

> "$AUDIO_DEVICES"
> "$BLOCK_DEVICES"
> "$INPUT_DEVICES"
> "$SYSTEM_DEVICES"
> "$GRAPHICS_DEVICES"

echo "=== Audio Devices ===" >> "$AUDIO_DEVICES"
echo "=== Block Devices ===" >> "$BLOCK_DEVICES"
echo "=== Input Devices ===" >> "$INPUT_DEVICES"
echo "=== System Devices ===" >> "$SYSTEM_DEVICES"
echo "=== Graphics Devices ===" >> "$GRAPHICS_DEVICES"

# Process audio devices
echo "Processing audio devices..."
for audio_dev in /dev/audio* /dev/eac /dev/snd/*; do
    if [ -e "$audio_dev" ]; then
        extract_device_info "$audio_dev" "audio" "$AUDIO_DEVICES"
    fi
done

# Process block devices
echo "Processing block devices..."
if [ -d "/dev/block" ]; then
    for block_dev in /dev/block/*; do
        if [ -e "$block_dev" ]; then
            extract_device_info "$block_dev" "block" "$BLOCK_DEVICES"
        fi
    done
fi

# Process input devices
echo "Processing input devices..."
if [ -d "/dev/input" ]; then
    for input_dev in /dev/input/*; do
        if [ -e "$input_dev" ]; then
            extract_device_info "$input_dev" "input" "$INPUT_DEVICES"
        fi
    done
fi

# Process system devices
echo "Processing system devices..."
system_devs="/dev/binder /dev/hwbinder /dev/vndbinder /dev/ashmem /dev/null /dev/zero /dev/random /dev/urandom /dev/kmsg"
for sys_dev in $system_devs; do
    if [ -e "$sys_dev" ]; then
        extract_device_info "$sys_dev" "system" "$SYSTEM_DEVICES"
    fi
done

# Process graphics devices
echo "Processing graphics devices..."
graphics_devs="/dev/ion /dev/graphics/*"
for gfx_dev in $graphics_devs; do
    if [ -e "$gfx_dev" ]; then
        extract_device_info "$gfx_dev" "graphics" "$GRAPHICS_DEVICES"
    fi
done

echo "========================================"
echo "PHASE 2: Extracting Runtime Information"
echo "========================================"

# Copy runtime system files
copy_runtime_info "/proc/cpuinfo" "$RUNTIME_INFO/cpuinfo.txt" "CPU Information"
copy_runtime_info "/proc/meminfo" "$RUNTIME_INFO/meminfo.txt" "Memory Information"
copy_runtime_info "/proc/version" "$RUNTIME_INFO/kernel_version.txt" "Kernel Version"
copy_runtime_info "/proc/partitions" "$RUNTIME_INFO/partitions.txt" "Partition Table"
copy_runtime_info "/proc/mounts" "$RUNTIME_INFO/mounts.txt" "Mount Points"
copy_runtime_info "/proc/modules" "$RUNTIME_INFO/loaded_modules.txt" "Loaded Modules"

# Generate additional runtime info
echo "Generating additional runtime information..."

# Mount command output
echo "Getting mount command output..."
mount > "$RUNTIME_INFO/mount_output.txt" 2>/dev/null

# Process list
echo "Getting process list..."
ps > "$RUNTIME_INFO/processes.txt" 2>/dev/null

# Disk usage
echo "Getting disk usage..."
df -h > "$RUNTIME_INFO/disk_usage.txt" 2>/dev/null

# Android properties
if command -v getprop >/dev/null 2>&1; then
    echo "Getting Android properties..."
    getprop > "$RUNTIME_INFO/android_properties.txt" 2>/dev/null
fi

echo "========================================"
echo "PHASE 3: Extracting SELinux Information"
echo "========================================"

# Copy SELinux policy files
copy_runtime_info "/file_contexts" "$SELINUX_INFO/file_contexts" "File Contexts Policy"
copy_runtime_info "/sepolicy" "$SELINUX_INFO/sepolicy" "SELinux Policy Binary"

# Get SELinux status
if command -v getenforce >/dev/null 2>&1; then
    echo "Getting SELinux enforcement status..."
    getenforce > "$SELINUX_INFO/selinux_mode.txt" 2>/dev/null
fi

# Directory contexts
echo "Getting directory SELinux contexts..."
echo "=== Directory SELinux Contexts ===" > "$SELINUX_INFO/directory_contexts.txt"
important_dirs="/ /dev /sys /proc /data /system /vendor"
for dir in $important_dirs; do
    if [ -d "$dir" ]; then
        ls -Zd "$dir" >> "$SELINUX_INFO/directory_contexts.txt" 2>/dev/null
    fi
done

echo "========================================"
echo "PHASE 4: Creating Device Recreation Script"
echo "========================================"

# Create device recreation script
RECREATE_SCRIPT="$BACKUP_DIR/recreate_devices.sh"
echo "Creating device recreation script..."

echo "#!/system/bin/sh" > "$RECREATE_SCRIPT"
echo "# Device Node Recreation Script" >> "$RECREATE_SCRIPT"
echo "# Generated from TWRP backup" >> "$RECREATE_SCRIPT"
echo "" >> "$RECREATE_SCRIPT"
echo "echo \"=== Recreating Device Nodes ===\"" >> "$RECREATE_SCRIPT"
echo "" >> "$RECREATE_SCRIPT"

# Read device inventory and create mknod commands
while IFS='|' read -r device_path device_type major_minor permissions selinux_context; do
    # Skip header lines and empty lines
    if [ -n "$device_path" ] && [ "${device_path#===}" = "$device_path" ]; then
        # Parse major and minor numbers
        major=$(echo "$major_minor" | cut -d' ' -f1)
        minor=$(echo "$major_minor" | cut -d' ' -f2)
        
        # Determine device type for mknod
        case "$device_type" in
            *"block"*)
                echo "mknod \"$device_path\" b 0x$major 0x$minor" >> "$RECREATE_SCRIPT"
                echo "chmod $permissions \"$device_path\"" >> "$RECREATE_SCRIPT"
                ;;
            *"character"*)
                echo "mknod \"$device_path\" c 0x$major 0x$minor" >> "$RECREATE_SCRIPT"
                echo "chmod $permissions \"$device_path\"" >> "$RECREATE_SCRIPT"
                ;;
        esac
    fi
done < "$DEVICE_LOG"

echo "echo \"Device recreation completed!\"" >> "$RECREATE_SCRIPT"
chmod +x "$RECREATE_SCRIPT"

echo "========================================"
echo "BACKUP SUMMARY"
echo "========================================"
echo "Backup location: $BACKUP_DIR"

# Count devices and generate summary
echo "Generating backup summary..."
total_devices=$(grep -c "|" "$DEVICE_LOG" 2>/dev/null || echo "0")
backup_size=$(du -sh "$BACKUP_DIR" 2>/dev/null | cut -f1)

# Write summary to file
echo "=== TWRP Device and Runtime Backup Summary ===" > "$SUMMARY_LOG"
echo "Generated: $(date)" >> "$SUMMARY_LOG"
echo "Backup Location: $BACKUP_DIR" >> "$SUMMARY_LOG"
echo "Total Backup Size: $backup_size" >> "$SUMMARY_LOG"
echo "" >> "$SUMMARY_LOG"
echo "=== DEVICE STATISTICS ===" >> "$SUMMARY_LOG"
echo "Total Devices: $total_devices" >> "$SUMMARY_LOG"
echo "" >> "$SUMMARY_LOG"
echo "=== FILES CREATED ===" >> "$SUMMARY_LOG"
echo "- Device Inventory: device_inventory.txt" >> "$SUMMARY_LOG"
echo "- Device Categories: device_categories/" >> "$SUMMARY_LOG"
echo "- Runtime Information: runtime_info/" >> "$SUMMARY_LOG"
echo "- SELinux Information: selinux_info/" >> "$SUMMARY_LOG"
echo "- Recreation Script: recreate_devices.sh" >> "$SUMMARY_LOG"

echo "Total backup size: $backup_size"
echo ""
echo "=== BACKUP STATISTICS ==="
echo "Total devices cataloged: $total_devices"
echo "Device categories processed: Audio, Block, Input, System, Graphics"
echo "Runtime info files: $(ls -1 "$RUNTIME_INFO" | wc -l)"
echo "SELinux files: $(ls -1 "$SELINUX_INFO" | wc -l)"
echo ""
echo "=== FILES CREATED ==="
echo "Device inventory: $DEVICE_LOG"
echo "Device categories: $DEV_CATEGORIES/"
echo "Runtime information: $RUNTIME_INFO/"
echo "SELinux information: $SELINUX_INFO/"
echo "Recreation script: $RECREATE_SCRIPT"
echo "Summary report: $SUMMARY_LOG"
echo ""
echo "=== Backup Complete ==="
echo "All device nodes and runtime information have been extracted successfully"
echo "Use recreate_devices.sh to recreate device nodes on target system"

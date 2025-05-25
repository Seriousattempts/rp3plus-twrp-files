#!/system/bin/sh

echo "=== TWRP Full Backup to SD Card (Multi-Method Copy with Logging) ==="
echo "Starting backup process..."

# Check if SD card is mounted
if [ ! -d "/external_sd" ]; then
    echo "ERROR: SD card not mounted at /external_sd"
    echo "Please mount your SD card first"
    exit 1
fi

# Create/use TWRP backup directory
BACKUP_DIR="/external_sd/TWRP"
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to create TWRP directory"
        exit 1
    fi
    echo "Created TWRP backup directory: $BACKUP_DIR"
else
    echo "Using existing TWRP backup directory: $BACKUP_DIR"
fi

# Initialize log files
ALL_FILES_LOG="$BACKUP_DIR/all_files.txt"
FAILED_FILES_LOG="$BACKUP_DIR/failed2copy.txt"

# Clear previous log files
> "$ALL_FILES_LOG"
> "$FAILED_FILES_LOG"

echo "Log files created:"
echo "- All attempted files: $ALL_FILES_LOG"
echo "- Failed copies: $FAILED_FILES_LOG"
echo ""

# Enhanced function with multiple copy methods and comprehensive logging
copy_with_multiple_methods() {
    src="$1"
    dst="$2"
    description="$3"
    item_name=$(basename "$src")
    
    echo "=== Copying: $item_name ==="
    echo "Description: $description"
    
    # Log every file/directory path to all_files.txt
    echo "$src" >> "$ALL_FILES_LOG"
    
    # Skip if source doesn't exist
    if [ ! -e "$src" ]; then
        echo "  SKIP: $item_name (doesn't exist)"
        echo "$src - REASON: Source doesn't exist" >> "$FAILED_FILES_LOG"
        echo ""
        return
    fi
    
    # Show directory contents count for directories
    if [ -d "$src" ]; then
        content_count=$(ls -1 "$src" 2>/dev/null | wc -l)
        echo "  Contains: $content_count items"
    fi
    
    # Method 1: Try standard cp -r
    echo "  Method 1: Standard cp -r"
    cp -r "$src" "$dst/" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "  Result: SUCCESS with cp -r"
        echo ""
        return
    fi
    echo "  Standard cp failed, trying alternatives..."
    
    # Method 2: Try with busybox cp (if available)
    if command -v busybox >/dev/null 2>&1; then
        echo "  Method 2: Busybox cp"
        busybox cp -r "$src" "$dst/" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "  Result: SUCCESS with busybox cp"
            echo ""
            return
        fi
        echo "  Busybox cp failed, trying next method..."
    fi
    
    # Method 3: Try rsync (if available)
    if command -v rsync >/dev/null 2>&1; then
        echo "  Method 3: rsync"
        rsync -a "$src" "$dst/" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "  Result: SUCCESS with rsync"
            echo ""
            return
        fi
        echo "  rsync failed, trying next method..."
    fi
    
    # Method 4: Try tar method (archives then extracts)
    echo "  Method 4: tar archive method"
    temp_tar="/tmp/backup_temp_$$.tar"
    if tar -cf "$temp_tar" -C "$(dirname "$src")" "$(basename "$src")" 2>/dev/null; then
        if tar -xf "$temp_tar" -C "$dst/" 2>/dev/null; then
            rm -f "$temp_tar" 2>/dev/null
            echo "  Result: SUCCESS with tar method"
            echo ""
            return
        fi
        rm -f "$temp_tar" 2>/dev/null
    fi
    echo "  tar method failed, trying next method..."
    
    # Method 5: Try with different permissions approach (individual file copy)
    echo "  Method 5: Individual file copy attempt"
    dest_path="$dst/$(basename "$src")"
    mkdir -p "$dest_path" 2>/dev/null
    
    # Try copying contents individually for directories
    if [ -d "$src" ]; then
        echo "  Attempting individual file copy..."
        success_count=0
        fail_count=0
        
        # Use find to get all files and directories in the source
        find "$src" -mindepth 1 -maxdepth 1 2>/dev/null | while read item; do
            if [ -e "$item" ]; then
                # Log individual file attempts
                echo "$item" >> "$ALL_FILES_LOG"
                
                cp -r "$item" "$dest_path/" 2>/dev/null
                if [ $? -eq 0 ]; then
                    success_count=$((success_count + 1))
                else
                    fail_count=$((fail_count + 1))
                    echo "$item - REASON: Individual copy failed" >> "$FAILED_FILES_LOG"
                fi
            fi
        done
        
        # Count actual copied items
        copied_items=$(ls -1 "$dest_path" 2>/dev/null | wc -l)
        if [ "$copied_items" -gt 0 ]; then
            echo "  Result: PARTIAL SUCCESS ($copied_items items copied)"
            echo ""
            return
        fi
    fi
    
    # Method 6: Try with find and cpio (preserves permissions better)
    echo "  Method 6: find + cpio method"
    if [ -d "$src" ]; then
        original_dir=$(pwd)
        cd "$src" 2>/dev/null
        if [ $? -eq 0 ]; then
            mkdir -p "$dst/$(basename "$src")" 2>/dev/null
            find . -depth | cpio -pdm "$dst/$(basename "$src")/" 2>/dev/null
            if [ $? -eq 0 ]; then
                cd "$original_dir"
                echo "  Result: SUCCESS with find+cpio"
                echo ""
                return
            fi
            cd "$original_dir"
        fi
    fi
    
    # Method 7: Try dd for files (byte-by-byte copy)
    if [ -f "$src" ]; then
        echo "  Method 7: dd byte copy (files only)"
        dd if="$src" of="$dst/$(basename "$src")" bs=1024 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "  Result: SUCCESS with dd"
            echo ""
            return
        fi
        echo "  dd method failed..."
    fi
    
    # All methods failed - log to failed files
    echo "  Result: ALL METHODS FAILED - Cannot access $item_name"
    echo "  This may be a virtual filesystem, special device, or requires elevated privileges"
    echo "$src - REASON: All copy methods failed (permission/access denied)" >> "$FAILED_FILES_LOG"
    echo ""
}

# Rest of your directory copying code with logging
echo "========================================"
echo "PHASE 1: Copying Root Directory Files"
echo "========================================"
echo "Backing up individual files from root directory (/)"

root_file_count=0
for item in /*; do
    if [ -f "$item" ] && [ "$item" != "/external_sd" ]; then
        copy_with_multiple_methods "$item" "$BACKUP_DIR" "Root system file"
        root_file_count=$((root_file_count + 1))
    fi
done

echo "Completed root files backup: $root_file_count files processed"
echo ""

echo "========================================"
echo "PHASE 2: Copying System Directories"
echo "========================================"

# Directory copying with enhanced methods and logging
copy_with_multiple_methods "/acct" "$BACKUP_DIR" "Process accounting information"
copy_with_multiple_methods "/apex" "$BACKUP_DIR" "APEX modules for system updates"
copy_with_multiple_methods "/config" "$BACKUP_DIR" "Kernel configuration filesystem"
copy_with_multiple_methods "/data" "$BACKUP_DIR" "User data and app data (CRITICAL)"
copy_with_multiple_methods "/data_mirror" "$BACKUP_DIR" "Mirror of data partition"
copy_with_multiple_methods "/debug_ramdisk" "$BACKUP_DIR" "Debug ramdisk contents"
copy_with_multiple_methods "/etc" "$BACKUP_DIR" "System configuration files"
copy_with_multiple_methods "/first_stage_ramdisk" "$BACKUP_DIR" "First stage ramdisk files"
copy_with_multiple_methods "/linkerconfig" "$BACKUP_DIR" "Dynamic linker configuration"
copy_with_multiple_methods "/metadata" "$BACKUP_DIR" "Partition metadata"
copy_with_multiple_methods "/mnt" "$BACKUP_DIR" "Mount points for filesystems"
copy_with_multiple_methods "/odm" "$BACKUP_DIR" "Original Design Manufacturer files"
copy_with_multiple_methods "/odmko" "$BACKUP_DIR" "ODM kernel objects"
copy_with_multiple_methods "/oem" "$BACKUP_DIR" "OEM specific files"
copy_with_multiple_methods "/overlay.d" "$BACKUP_DIR" "Overlay filesystem configuration"
copy_with_multiple_methods "/postinstall" "$BACKUP_DIR" "Post-installation scripts"
copy_with_multiple_methods "/product" "$BACKUP_DIR" "Product-specific system files"
copy_with_multiple_methods "/sbin" "$BACKUP_DIR" "System binaries and recovery tools"
copy_with_multiple_methods "/sdcard" "$BACKUP_DIR" "Internal storage symlink/mount"
copy_with_multiple_methods "/sideload" "$BACKUP_DIR" "ADB sideload mount point"
copy_with_multiple_methods "/socko" "$BACKUP_DIR" "Socket operations directory"
copy_with_multiple_methods "/storage" "$BACKUP_DIR" "Storage mount points"
copy_with_multiple_methods "/system" "$BACKUP_DIR" "Core Android system files (CRITICAL)"
copy_with_multiple_methods "/system_ext" "$BACKUP_DIR" "Extended system partition"
copy_with_multiple_methods "/system_root" "$BACKUP_DIR" "System root filesystem"
copy_with_multiple_methods "/systeminfo" "$BACKUP_DIR" "System information files"
copy_with_multiple_methods "/tmp" "$BACKUP_DIR" "Temporary files"
copy_with_multiple_methods "/twres" "$BACKUP_DIR" "TWRP resources and themes"
copy_with_multiple_methods "/vendor" "$BACKUP_DIR" "Vendor-specific files and drivers (CRITICAL)"

echo "========================================"
echo "BACKUP SUMMARY"
echo "========================================"
echo "Backup location: $BACKUP_DIR"

# Count total attempted and failed files
total_attempted=$(wc -l < "$ALL_FILES_LOG" 2>/dev/null || echo "0")
total_failed=$(wc -l < "$FAILED_FILES_LOG" 2>/dev/null || echo "0")
total_successful=$((total_attempted - total_failed))

backup_size=$(du -sh "$BACKUP_DIR" 2>/dev/null | cut -f1)
echo "Total backup size: $backup_size"
echo ""
echo "=== COPY STATISTICS ==="
echo "Total files/directories attempted: $total_attempted"
echo "Successfully copied: $total_successful"
echo "Failed to copy: $total_failed"
echo ""
echo "=== LOG FILES CREATED ==="
echo "All attempted paths: $ALL_FILES_LOG"
echo "Failed copy paths: $FAILED_FILES_LOG"
echo ""
echo "=== Backup Complete ==="
echo "Multiple copy methods were attempted for maximum compatibility"
echo "Check failed2copy.txt for items that couldn't be copied due to permissions"
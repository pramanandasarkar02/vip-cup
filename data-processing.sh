#!/bin/bash

# Source directory containing the files
SOURCE_DIR=".......vip/releasev1-detection&tracking/RGB/images"

# Output directory where files will be copied
OUTPUT_DIR="............vip/data/RGB/images"

## Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory $SOURCE_DIR does not exist!"
    exit 1
fi

# Check if output directory exists, create it if it doesn't
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
    echo "Created output directory $OUTPUT_DIR"
fi

# Iterate through all files in the source directory
for file in "$SOURCE_DIR"/*; do
    # Check if it's a file
    if [ -f "$file" ]; then
        # Extract filename from path
        filename=$(basename "$file")
        
        # Check if filename matches the pattern (e.g., BIRD_01574_xxx or DRONE_004_xxx)
        if [[ $filename =~ ^(BIRD_[0-9]+|DRONE_[0-9]+)_.*$ ]]; then
            # Extract the prefix (e.g., BIRD_01574 or DRONE_004)
            prefix="${BASH_REMATCH[1]}"
            
            # Create destination directory in output directory if it doesn't exist
            DEST_DIR="$OUTPUT_DIR/$prefix"
            mkdir -p "$DEST_DIR"
            
            # Copy the file to the destination directory
            cp "$file" "$DEST_DIR/"
            # echo "Copied $filename to $DEST_DIR/"
        else
            echo "Skipping $filename: does not match pattern"
        fi
    fi
done

echo "File separation and copying complete!"
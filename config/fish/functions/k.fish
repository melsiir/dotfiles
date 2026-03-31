function k
    if test -z "$argv"
        # No argument: find first .kt file in current directory
        set file (ls *.kt 2>/dev/null | head -n 1)
        if test -z "$file"
            echo "Error: No .kt files found in current directory"
            return 1
        end
    else
        set file $argv[1]
        
        # Remove @ prefix if present
        if string match -q '@*' "$file"
            set file (string sub -s 2 "$file")
        end
    end
    
    # Check if file exists
    if not test -f "$file"
        echo "Error: File '$file' not found"
        return 1
    end
    
    # Get filename without .kt extension
    set jarfile (string replace '.kt' '.jar' "$file")
    
    # Compile and run
    kotlinc "$file" -include-runtime -d "$jarfile" && java -jar "$jarfile"
end

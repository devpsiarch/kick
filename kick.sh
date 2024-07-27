#!/bin/bash

arg_array=("$@")
dir=${arg_array[-1]}

if [ "$dir" == "-help" ]; then
    # Print help information when the -help flag is passed
    echo "Project setup script: setupt <flags> <directory>"
    echo "-help => show manual"
    echo "-gi => create gitignore file and write to it"
    echo "-r => create a README file and also write to it"
    echo "-l => create a logs file and write to it"
    echo "-sf => create stat file with specified filename in the chosen language {C}"
    exit 0 # Exit the script after printing help
fi

if [ ! -d "$dir" ]; then
	echo "Creating directory: $dir"
	mkdir $dir
fi

echo "<--------------------->"

for arg in "$@"; do
    case $arg in
        "$dir")
            # Exit loop if the argument matches the directory name
            break ;;
        "-gi")
            # Create .gitignore file and prompt for content
            touch "$dir/.gitignore"
            read -p ".gitignore file: " content
            echo "$content" > "$dir/.gitignore" ;;
        "-r")
            # Create README.md file and prompt for content
            touch "$dir/README.md"
            read -p "README file: " content
            echo "$content" > "$dir/README.md" ;;
        "-l")
            # Create logs.txt file and prompt for content
            touch "$dir/logs.txt"
            read -p "Logs file: " content
            echo "$content" > "$dir/logs.txt" ;;
        "-sf")
            # Prompt for language and create a new file based on the language
            read -p "What language? " lang
            if [ "$lang" = "c" ]; then
                read -p "Filename: " filename
				echo "int main(void){return 0;}" > "$dir/$filename.c"
            fi ;;
    esac
done

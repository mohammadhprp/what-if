#! /bin/bash

# Run flutter test
flutter test

# Check if the command was successful
if [ $? -eq 0 ]; then
    # Push changes to GitHub 
    git push --follow-tags --force

fi
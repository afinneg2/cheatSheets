# cheetSheets

References, tips and instructions for doing common tasks

## Install

1. Clone: ```git clone <repository URL>```

2. For quick access to refrence sheets add following line to your .bashrc

   ```bash
    source /path/to/repo/cheetSheets/aliases.sh
   ```

   This makes the following aliases available:

   ```bash
   quickRef   ## quickRef.md in your default markdown editor
   ```



## Updating repository

1. Edit quickRef.md

2. Update the corresponding file in ```./display_github``` by running

   ```bash
   make
   ```

3. Push to github

   
Quick/practical references for common tasks

[TOC]

# Coding 

## Bash

#### Command line parsing: quick and dirty

```bash
#!/bin/bash
echo "total number of arguments is ${#@}"  ## does not include the script name
echo "script name is $0"
echo "first argument is $1"
echo "second argument is $2"
#...
```

#### Command line parsing: getopts

+ https://wiki.bash-hackers.org/howto/getopts_tutorial

+ Basic example

  ```bash
  function test1 () {
      function func_usage() { echo "Usage: test1 -ac -b <parameter>"; return 0 ; }
  
      local OPTIND opt a b c  ## Only needed inside function
      while getopts "ab:c" opt; do ## -a and -c are flags, -b is option with argument 
          case "$opt" in
                  a)
                  echo "-a triggered"
                  ;;
                  b)
                  echo "setting local variable b"
                  local b=$OPTARG  ##OPTARG stores the flag or unknown option
                  echo "local b is $b"
                  ;;
                  c)
                  echo "-c triggered"
                  ;;
                  \?)   ## What is \? ? this gets triggered with by undefined flag
                  func_usage
                  return 1
                  ;;
                  :)  ## this gets triggered by option missing its argument
                  func_usage
                  return 1
                  ;;
          esac
      done
      return 0
  }
  ```

#### Basic loop syntax

+ Looping over arrays

  ```bash
  arr1= ("a" "b" "c")
  ## Method 1
  for i in ${arr1[@]}
  	do
  	echo $i
  done
  ## Method 2 - advantage: can loop over multiple arrays with same index
  for (( i=0; i<${#arr1[@]}; i++ ))  ## itialize, test, update 
          do
          echo $i
  done
  ```

+ While loop: TODO write this

#### String trimming

+ Prefixes  and suffixes

  ```bash
  x=prefix_xyxyx_suffix
  echo ${x#prefix_} ## removes prefix ->xyxyx_suffix
  echo ${x%_suffix}  ## remove suffix -> prefix_xyxyx
  ```

+ file extensions and basenames

  ```bash
  fname=/path/to/myfile.ext
  filename=$(basename $fname)  ## myfile.ext
  extension="${filename##*.}" ## ext
  filename="${filename%.*}"  ## /path/to/myfile
  ```

#### Prepend/append to array elements

```bash
array=( "${array[@]/#/prefix_}" )
array=( "${array[@]/%/_suffix}" )
```

#### Default variable values

+ https://unix.stackexchange.com/questions/122845/using-a-b-for-variable-assignment-in-scripts/122878

```bash
a="${:-default}"  ## if a undefined or empty string then set to default. Otherwise unchanged
```

#### Named arrays

+ TODO: write this

#### Redirection of multiple input streams

+ Example :  `comm` program takes two sorted input files and outputs — col 1: lines in 1st file , col 2: lines in 2nd file, col 3: lines in both files.

  ```bash
  ### suppose file 1 and file 2 not presorted
  comm <( sort file1.txt ) <( sort file2.txt )  > comm.out.txt 
  ## Technically I think <( ) creates temp files, so not really streams
  ```

## Python

#### Command line parsing: sys.argv

```python
import sys
print( sys.argv[0])  ## script name (sys.argv is just a list)
print( sys.argv[1])  ## First string after script name
```

#### Comman line parsing: argparse

```python
import argparse

parser = argparse.ArgumentParser(description = "DESCRIBE SCRIPT")
parser.add_argument( "-i", "--input" required = True , type = str , help = "DESCRIBE",nargs = "+") ## allows >1 arg
parser.add_argument(  "--genome" , type = str )
parser.add_argument("--float1" , default = 0.2 , type = float)
dummyArgs = '--i x y --genome x' ## Use for debugging in a notebook. comment out in script
args =  parser.parse_args(dummyArgs.split())

args.input ## [ 'x' , 'y']
args.genome ## 'x'
args.float ## 0.2
```

#### Matplotlib

+ setting good color schemes: TODO write this
+ good matplotlib.rc file : TODO add this as a separate document

#### gzip module

To save gzip compressed pickle files use  [^python_gzip] 

```python
f = gzip.open("myFile.pklz", 'wb')
pickle.dump(myObj, f)
f.close()
```

## R

#### Command line parsing: quick and dirty 

```R
args = commandArgs(trailingOnly = TRUE ) ## args is a character vector
print(args[1]) ## arg1 when invoked as Rscript myScript.R arg1 arg2
print(args[2]) ## arg2 when invoked as Rscript myScript.R arg1 arg2
#...
```

#### Command line parsing: argparser library

```R
library("argparser")
#######################################################################################
#### PARSE
p <- arg_parser(description = "My description")
p <- add_argument(p, "--param1", default= "optional", type = "default is 'string' another option is numeric" , help = "Must have help or will throw error" )
p <- add_argument(p , "--flag1" , flag= TRUE, help = "" )  ## this is a flag
p <- add_argument(p , "param2" , help = "")
# ...
argv <- parse_args(p) ## this will parse from the trailing arguments to scrip at cmd line
## For debug you might want to pass arguments inside an R session and not from cmd line:
## To this using
## argv <- parse_args(p, c("--param1" , "param1_value", "--flag1" , "--param2" "param2_value"))
###########################################################################################
#### Using the argv oject
## Accessing parameter arguments
argv$param1 
## Testing flags
if (args$flag1){
    ## do something
}
## Testing if parameter is unspecified
if ( is.na(argv$param2) ){
    print("param2 value not specified")
}
```

#### Read file into array

```R
arr <- scan(file , what = "character")
```

#### Write array 

```R
write(myArr , file="myFname", sep = "\n")
```



#### Install package locally

1. Download the .tar.gz file for package from https://cran.r-project.org/

2. Run command:

   ```bash
   R CMD INSTALL -l <My/local/lib> <pkgName>.tar.gz
   ```

TODO: Add instructions for local install from within R session

#### library paths

Multiple methods for setting custom library paths

+  `library("<pkgName>" , lib.loc="<My/local/lib>")`

+ ```.libPaths()``` — with no argument prints path search for R libraries ordered by decreasing prescients. With path argument, prepends the path to search list.

+ analogue of PYTHONPATH

  ```R
  ## add the following line to .Rconfig  at ~ or .
  .libPaths("/path/to/my/libs")
  ```

  Alterntive is setting `R_LIBS` or `R_LIBS_USER` in `.Renviron` file (located at `~`  or `.`) [^R_LIBS]

#### Installing multiple R versions on same machine

- https://irvingduran.com/2016/10/installing-multiple-version-of-r-on-the-same-machine-for-macos-mac/

##  AWK

#### If/else

```bash
awk -F , '{ if ( <condition> ) {<action1>; <action2> } else { <action> } }' <f_in>
```

#### passing external variables

```bash
var1=2
var2=4
awk -v x=$var1 -v y=$var2 '$2 == x {print y " " $1}' <f_in>
```

#### printf

```bash
awk '{printf "%s\t%s\t%s\n" , $1 , $2 , $3}'
```

# Biocluster / SLURM

#### Setup local install directory and ```pip install --user <packageName>```

+ Setup (Only need to do this once) 

  1. Create a ```.local```  directory for user-specific python packages: 

     ```bash 
     mkdir /home/my/prefered/dir/.local
     ```

  2. Set ```PYTHONUSERBASE``` environmental variable by adding the following line to your .bashrc :

     ```bash
     export PYTHONUSERBASE="/home/my/prefered/dir/.local"
     ```

     then,

     ```bash
     source ~/.bashrc 
     ```

+ Installing your packages

  ```bash
  pip install --user <MyPackageName>  ##make sure your preferred version of python is loaded
  ```

#### `sbatch` — basic  

```bash
sbatch -p <queue> --cpus-per-task=1 --mem=12GB -D <workDir> --job-name=<jobName>  -o "oe/<jobName>.o" -e "oe/<jobName>.e" --export=var1=$var1,var2=$var2... PATH/TO/SCRIPT/example.slurm
```

+ ```var1``` and ```var2``` are passed to example.slurm

#### `sbatch` — without slurm script

```bash
sbatch -p <queue> --cpus-per-task=1 --mem=12GB -D <workDir> --job-name=<jobName>  -o "oe/<jobName>.o" -e "oe/<jobName>.e" <<EOF
#!/bin/bash  
script_line1 ##lines will be submitted by slurm just like they were in a script
script_line2
...
EOF
```

#### Jupyter on biocluster

1. Login to biocluster and start an interactive session on a compute node. Replace <node_name> with amdsong, intelsong, or gpusong. 

1. ```bash
   ssh <username>@biologin.igb.illinois.edu
   srun -p <node_name> --pty /bin/bash
   ```

   You can also add other parameters when using the srun command. For example, if you want to use a single GPU and alot 50 Gb of memory, you can run:

   ```bash
   srun -p gpusong --mem=50G --gres=gpu:1 --pty /bin/bash
   ```

2. In your interactive session, load jupyter and other modules you will be needing. For example: 

   ```bash 
   module swap Python Python/3.6.1-IGB-gcc-4.9.4
   module swap PyTorch PyTorch/0.4.0-IGB-gcc-4.9.4-Python-3.6.1
   module load jupyter/1.0.0-IGB-gcc-4.9.4-Python-3.6.1
   ```

3. Start jupyter in an interactive session on the compute node. Replace XXXXX with a five digit number between 10000 and 20000 that hopefully nobody else will be using (e.g. 10834).

   ```bash
   jupyter notebook --no-browser --port=XXXXX
   ```

   You will likely see a message that looks like this:

   ```bash
   Copy/paste this URL into your browser when you connect for the first time,
   to login with a token:
       http://localhost:XXXXX/?token=44777927a9c2d1921cbf4eef7dd7f18608b3ed71c5b56658
   ```

   You may need to use the long string of digits and letters as authentication in the very last step, so keep track of this.

4. **On your own computer**, run the command:

   ```bash
   ssh -t -t <username>@biologin.igb.illinois.edu -L XXXXX:localhost:XXXXX ssh <compute-0-1> -L XXXXX:localhost:XXXXX
   ```

   where XXXXX is the same XXXXX from step 3, <username> is replaced by your biocluster username, and <compute-0-1> is replaced by the name of the particular node that you happen to be on (should probably show up on the terminal window in which you're running an interactive session).

5. Open up a window in your web browser (e.g. Chrome, Safari) and type in the url: [http://localhost:XXXXX](http://localhost:xxxxx) where XXXXX is the same XXXXX used in the previous steps.

6. (Usually only the first time) you may have to input the token from step 3 to start.

(The above steps worked as of 4/11/2019)

# Jupyter notebooks

#### Use the full window

+ Execute the following line in a cell

  ```python
  from IPython.core.display import display, HTML
  display(HTML("<style>.container { width:100% !important; }</style>"))
  ```

+ Or, add the following line to the file ```~./jupyter/custom/custom.css```:

  ```css
  .container { width:100%: !important; }
  ```


# Git and githib

#### Push to remote repository (remote repository URL already set)

```bash
git add .   ## To unstage a file use:  git reset HEAD <YOUR-FILE> , --dry-run is a good option
git commit -m <commit message>  
git push origin master 
```

#### Check if local repository is up-to-date

+ https://stackoverflow.com/questions/7938723/git-how-to-check-if-a-local-repo-is-up-to-date)

```bash
git remote show origin   ## AF: is this really better than git fetch and then some difference commed ? 
# Returns something like:
#HEAD branch: master
#  Remote branch:
#    master tracked
#  Local branch configured for 'git pull':
#    master merges with remote master
#  Local ref configured for 'git push':
#    master pushes to master (local out of date)  ##<-------
```

#### Force git pull to overwrite local files

+ https://stackoverflow.com/questions/1125968/how-do-i-force-git-pull-to-overwrite-local-files

  ```bash
  git fetch --all
  git reset --hard origin/<branchName>  ## branchName is probably master
  ```

#### Delete tracked files from github

How to delete a tracked file that has been pushed to GitHub

```bash
# Ensure your are in correct brach
git checkout master
git rm <fname>   ## Deletes the file (if it exists) and stop it from being tracked, can also be git rm -r <dirName>
git commit -m "<message>"
git push origin master
```

#### Push to new github repository

```bash
## First create repository on GitHub
git remote add <myCustomName> <repo URL>
git push <myCustomName> master  ## alternate is:  git push  <repo URL> master
## From https://stackoverflow.com/questions/42084116/pushing-to-a-different-git-repo/42084519
```

#### References

+ https://blog.osteele.com/2008/05/my-git-workflow/

# Markdown

Markdown is a simple language that lets you write text, tables, code blocks (syntax highlighting), math (latex syntax) and more. Markdown files have .md extension

+ A good code editor for markdown is Typora (https://typora.io/)
+ A good reference for the markdown language is https://support.typora.io/Markdown-Reference/

# Distributing code

### Sharing analysis

When the goal is reproducibility (rather than a code library that evolves with time) use `pip install -r requirements.txt`

+ Provide `requirements.txt` , with format described at  [^pip_requirements]. The following example is a quick reference:

  ```
  ## For packages in Pypi reference using one of these formats:
  numpy
  scipy ==1.0.0
  matplotlib >=2.1.2
  ## For packages on github an acceptible format is:
  git+https://github.com/KrishnaswamyLab/MAGIC.git@0.1#egg=magic
  ```

  _@tag_ specifices a taged version of repo;  _#egg=\<pakageName\>_ is necessary

+ Install all requirements with

  ```bash
  pip install -r requirements.txt
  ```

### Sharing packages

When the goal is a code library that evolves with dependencies use `setupy.py` file.  

Random facts:

 + setup.py should be in root directory for your package

TODO: elaborate

### Virtual environments in python

+ Virtual envrionments (VE) — python envronment (python interpreter, packages, and environemntal variables) that is isolated from your global environment.  
+ Working in a VE lets you run code with specific package versions different from those in global environment

 To creare VE, run (python >=3.3 ):

```bash
python -m venv --prompt <myPromt> <dirName>    ## creates a virtual environment in <dirName> (which can be .)
## navigate to <dirName>
source bin/activate ## used command "deactivate" to revert to global environment
```

The result is a directory structure :

```
.
├── bin
│   ├── activate
...  ├── <other stuff>
│   ├── pip
│   ├── python -> /home/apps/software/Anaconda3/5.1.0/bin/python
│   └── python3 -> python
├── include
├── lib
│   └── python3.6
│       └── site-packages  <- when VE active python packages install and load from here
├── lib64 -> lib
└── pyvenv.cfg
```

References

+ https://packaging.python.org/tutorials/installing-packages/#creating-virtual-environments
+ https://docs.python.org/3/library/venv.html#venv-def

# Misc

#### tar/untar directory

+ Tar

  ​	```tar -zcvf archive-name.tar.gz directory-name```

  + see https://www.cyberciti.biz/faq/how-do-i-compress-a-whole-linux-or-unix-directory/

+ Untar

  + TODO: add example

#### Monitoring Process resources 

+ Mem and CPU usage:  `./scripts/top_watch.sh`



# Footnotes

[^pip_requirements]: https://pip.pypa.io/en/stable/reference/pip_install/#requirements-file-format, https://pip.pypa.io/en/stable/user_guide/#requirements-files
[^R_LIBS]: Add a reference  
[^python_gzip]: http://henrysmac.org/blog/2010/3/15/python-pickle-example-including-gzip-for-compression.html


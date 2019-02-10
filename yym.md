Quick/practical references for common tasks

[Coding](#header-n3)  
	[Bash](#header-n4)  
			[Command line parsing: quick and dirty](#header-n5)  
			[Command line parsing: getopts](#header-n7)  
			[Basic loop syntax](#header-n14)  
			[String trimming](#header-n21)  
			[Prepend/append to arrays](#header-n29)  
			[Default variable values](#header-n31)  
			[Named arrays](#header-n36)  
			[Redirection of multiple input streams](#header-n40)  
	[Python](#header-n44)  
			[Command line parsing: sys.argv](#header-n45)  
			[Comman line parsing: argparse](#header-n47)  
			[Matplotlib](#header-n51)  
	[R](#header-n57)  
			[Read file into array](#header-n58)  
			[Write array ](#header-n60)  
			[Command line parsing: quick and dirty ](#header-n62)  
			[Command line parsing: argparser library](#header-n64)  
			[Install package locally](#header-n66)  
			[Installing multiple version on same machine](#header-n76)  
	[AWK](#header-n81)  
			[If/else](#header-n82)  
			[passing external variables](#header-n84)  
			[printf](#header-n86)  
[Biocluster / SLURM](#header-n89)  
			[Setup local install directory and
`pip install --user <packageName>`](#header-n90)  
			[`sbatch` - basic ](#header-n109)  
			[`sbatch` - without slurm script](#header-n114)  
[Jupyter notebooks](#header-n117)  
			[Use the full window](#header-n118)  
[Git and githib](#header-n127)  
			[Push to remote repository (remote repository URL already
set)](#header-n128)  
			[Check if local repository is up-to-date](#header-n139)  
			[Force git pull to overwrite local files](#header-n144)  
			[References](#header-n149)  
[Markdown](#header-n153)  
[Misc](#header-n160)  
			[tar/untar directory](#header-n161)

Coding {#header-n3}
======

Bash {#header-n4}
----

#### Command line parsing: quick and dirty {#header-n5}

~~~~ shell
#!/bin/bash
echo "total number of arguments is ${#@}"  ## does not include the script name
echo "script name is $0"
echo "first argument is $1"
echo "second argument is $2"
#...
~~~~

#### Command line parsing: getopts {#header-n7}

-   https://wiki.bash-hackers.org/howto/getopts\_tutorial

-   Basic example

    ~~~~ shell
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
    ~~~~

#### Basic loop syntax {#header-n14}

-   Looping over arrays

    ~~~~ shell
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
    ~~~~

-   While loop: TODO write this

#### String trimming {#header-n21}

-   Prefixes and suffixes

    ~~~~ shell
    x=prefix_xyxyx_suffix
    echo ${x#prefix_} ## removes prefix ->xyxyx_suffix
    echo ${x%_suffix}  ## remove suffix -> prefix_xyxyx
    ~~~~

-   file extensions and basenames

    ~~~~ shell
    fname=/path/to/myfile.ext
    filename=$(basename $fname)  ## myfile.ext
    extension="${filename##*.}" ## ext
    filename="${filename%.*}"  ## /path/to/myfile
    ~~~~

#### Prepend/append to arrays {#header-n29}

~~~~ shell
array=( "${array[@]/#/prefix_}" )
array=( "${array[@]/%/_suffix}" )
~~~~

#### Default variable values {#header-n31}

-   https://unix.stackexchange.com/questions/122845/using-a-b-for-variable-assignment-in-scripts/122878

~~~~ shell
a="${:-default}"  ## if a undefined or empty string then set to default. Otherwise unchanged
~~~~

#### Named arrays {#header-n36}

-   TODO: write this

#### Redirection of multiple input streams {#header-n40}

-   TODO: write this

Python {#header-n44}
------

#### Command line parsing: sys.argv {#header-n45}

~~~~ python
import sys
print( sys.argv[0])  ## script name (sys.argv is just a list)
print( sys.argv[1])  ## First string after script name
print(sys.argv[2])   ## Second string after script name
~~~~

#### Comman line parsing: argparse {#header-n47}

-   TODO: basic example

#### Matplotlib {#header-n51}

-   setting good color schemes: TODO write this

-   good matplotlib.rc file : TODO add this as a separate document

R {#header-n57}
-

#### Read file into array {#header-n58}

~~~~ r
arr <- scan(file , what = "character")
~~~~

#### Write array  {#header-n60}

~~~~ r
write(myArr , file="myFname", sep = "\n")
~~~~

#### Command line parsing: quick and dirty  {#header-n62}

~~~~ r
args = commandArgs(trailingOnly = TRUE ) ## args is a character vector
print(args[1]) ## arg1 when invoked as Rscript myScript.R arg1 arg2
print(args[2]) ## arg2 when invoked as Rscript myScript.R arg1 arg2
#...
~~~~

#### Command line parsing: argparser library {#header-n64}

~~~~ r
library("argparser")
####################################################
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

########################################################
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
~~~~

#### Install package locally {#header-n66}

1.  Download the .tar.gz file for package from
    https://cran.r-project.org/

2.  Run command:

    ~~~~ shell
    R CMD INSTALL -l <My/local/lib> <pkgName>.tar.gz
    ~~~~

3.  To import library into R script use

    ~~~~ r
    library("<pkgName>" , lib.loc="<My/local/lib>")
    ~~~~

#### Installing multiple version on same machine {#header-n76}

-   https://irvingduran.com/2016/10/installing-multiple-version-of-r-on-the-same-machine-for-macos-mac/

AWK {#header-n81}
---

#### If/else {#header-n82}

~~~~ shell
awk -F '{ if ( <condition> ) {<action1>; <action2> } else { <action> } }' <f_in>
~~~~

#### passing external variables {#header-n84}

~~~~ shell
var1=2
var2=4
awk -v x=$var1 -v y=$var2 '$2 == x {print y " " $1}' <f_in>
~~~~

#### printf {#header-n86}

~~~~ shell
awk '{printf "%s\t%s\t%s\n" , $1 , $2 , $3}'
~~~~

Biocluster / SLURM {#header-n89}
==================

#### Setup local install directory and `pip install --user <packageName>` {#header-n90}

-   Setup (Only need to do this once)

    1.  Create a `.local` directory for user-specific python packages:

        ~~~~ shell
        mkdir /home/my/prefered/dir/.local
        ~~~~

    2.  Set `PYTHONUSERBASE` environmental variable by adding the
        following line to your .bashrc :

        ~~~~ shell
        export PYTHONUSERBASE="/home/my/prefered/dir/.local"
        ~~~~

        then,

        ~~~~ shell
        source ~/.bashrc 
        ~~~~

-   Installing your packages

    -   With your preferred version of python loaded run

        ~~~~ shell
        pip install --user <MyPackageName>
        ~~~~

#### `sbatch` - basic  {#header-n109}

~~~~ shell
sbatch -p <queue> --cpus-per-task=1 --mem=12GB -D <workDir> --job-name=<jobName>  -o "oe/<jobName>.o" -e "oe/<jobName>.e" --export=var1=$var1,var2=$var2... PATH/TO/SCRIPT/example.slurm
~~~~

-   `var1` and `var2` are passed to example.slurm

#### `sbatch` - without slurm script {#header-n114}

~~~~ shell
sbatch -p <queue> --cpus-per-task=1 --mem=12GB -D <workDir> --job-name=<jobName>  -o "oe/<jobName>.o" -e "oe/<jobName>.e" <<EOF
#!/bin/bash  
script_line1 ##lines will be submitted by slurm just like they were in a script
script_line2
...
EOF
~~~~

Jupyter notebooks {#header-n117}
=================

#### Use the full window {#header-n118}

-   Execute the following line in a cell

    ~~~~ python
    from IPython.core.display import display, HTML
    display(HTML("<style>.container { width:100% !important; }</style>"))
    ~~~~

-   Or, add the following line to the file
    `~./jupyter/custom/custom.css`:

    ~~~~ css
    .container { width:100%: !important; }
    ~~~~

Git and githib {#header-n127}
==============

#### Push to remote repository (remote repository URL already set) {#header-n128}

1.  Stage (adds files in local repository to set of staged files)

    ~~~~ shell
    git add .   ## To unstage a file use:  git reset HEAD <YOUR-FILE>
    ~~~~

2.  Commit

    ~~~~ shell
    git commit -m <commit message>
    ~~~~

3.  Push

    ~~~~ shell
     git push -u origin master
    ~~~~

#### Check if local repository is up-to-date {#header-n139}

-   https://stackoverflow.com/questions/7938723/git-how-to-check-if-a-local-repo-is-up-to-date)

~~~~ shell
git remote show origin 
# Returns something like:
#HEAD branch: master
#  Remote branch:
#    master tracked
#  Local branch configured for 'git pull':
#    master merges with remote master
#  Local ref configured for 'git push':
#    master pushes to master (local out of date)  ##<-------
~~~~

#### Force git pull to overwrite local files {#header-n144}

-   https://stackoverflow.com/questions/1125968/how-do-i-force-git-pull-to-overwrite-local-files

    ~~~~ shell
    git fetch --all
    git reset --hard origin/<branchName>  ## branchName is probably master
    ~~~~

#### References {#header-n149}

-   TODO: add some good ones (concise)

Markdown {#header-n153}
========

Markdown is a simple language that lets you write text, tables, code
blocks (syntax highlighting), math (latex syntax) and more. Markdown
files have .md extension

-   A good code editor for markdown is Typora (https://typora.io/)

-   A good reference for the markdown language is
    https://support.typora.io/Markdown-Reference/

Misc {#header-n160}
====

#### tar/untar directory {#header-n161}

-   Tar

     `tar -zcvf archive-name.tar.gz directory-name`

    -   see
        https://www.cyberciti.biz/faq/how-do-i-compress-a-whole-linux-or-unix-directory/

-   Untar

    -   TODO: add example



## Methods for local installation of python packages (useful when working on cluster)

List of methods:

I. Setup local install directory and ```pip install --user <packageName>```

II. Virtualenv (TODO: write this)

## I. Setup local install directory and ```pip install --user <packageName>```

#### Setup (Only need to do this once) 

1. Create a ```.local```  directory for user-specific python packages:

   e.g.

   ```bash 
   mkdir /home/my/prefered/dir/.local
   ```

2. Set ```PYTHONUSERBASE``` environmental variable by adding the following line to your .bashrc :

   ```bash
   export PYTHONUSERBASE="/home/my/prefered/dir/.local"
   ```

   Whenever a new terminal is opened the ```PYTHONUSERBASE``` variable will be set. To set it in this session run (a one time thing):

   ```bash
   source ~/.bashrc 
   ```

3. Check that Python sees the new environmental variable by running:

   ```bash
   python -c "import site; print(site.USER_BASE)"
   ```

   this should return the path to your .local directory

#### Installing your packages

To install a package available in pip, make sure your desired version of python is loaded on the cluster and run

```bash
pip install --user <MyPackageName>
```

#### Importing your packages 

Finally, you need to put your user-specific package directory on the PYTHONPATH. There are two ways to do this:

1. modifying .bashrc. (permanent solution )

   Add the following line to your .bashrc file

   ```bash
   export PYTHONPATH=/home/my/prefered/dir/.local/lib/python3.6/site-packages:${PYTHONPATH}
   ```

   In addition to replacing my/preferred/dir/ your may also need to change the name of the python3.6/ directory. Look in ```/home/my/preferred/dir/.local```  to find the path to the ```site-packages```  directory 

2. modifying the PYTHONPATH in an individual script (temporary solution )

   ```python
   import sys
   sys.path.insert(0, "/home/my/prefered/dir/.local/lib/python3.6/site-packages")
   import MyLocalInstallPackageName
   ```

   In addition to replacing my/preferred/dir/ your may also need to change the name of the python3.6/ directory. Look in ```/home/my/preferred/dir/.local```  to find the path to the ```site-packages```  directory 

#### References

https://pip.readthedocs.io/en/latest/user_guide/#user-installs

## II. Virtualenv

TODO: Write this

 






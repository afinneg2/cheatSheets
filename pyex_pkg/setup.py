from setuptools import setup, find_packages
## For a more detailed example see https://github.com/pypa/sampleproject/blob/master/setup.py
long_description = 'Long description of my package'
 
setup(name='pyex_pkg', # name your package
      packages=['pyex_pkg'], # list all subdirectories that correspond to packages
## alternative: packages= find_packages(exclude=['contrib', 'docs', 'tests']), 
      version='1.0.0', 
      description='Short description of my package',
      long_description=long_description,
      url='http://example.org/pyex_pkg',
      author='My Name',
      author_email='my.name@example.org',
      license = "MIT", ## chose the appropriate license
      install_requires= [ 'nltk' ],  ## list package dependencies
      entry_points={  # Use this to define any commnand line utilities included in your package.
        'console_scripts': [
            'pysetup_helloworld=pyex_pkg.myscript_helloworld:main',
        ],
    },
)

# CS5344_project

### Fresh installation of miniconda
We use miniconda to help us maintain a consistent environment. <br/>
Follow the installation instructions for your operating system: <br/>
https://docs.conda.io/en/latest/miniconda.html <br/>

### Creating the environment
After installation, run these commands from the "setup" folder to activate the environment:
```
cd setup
conda env create --name bdat -f environment.yml
```

### Using the environment
To use the environment:
```
conda activate bdat
```
In the conda console, launch jupyter notebook:
```
jupyter notebook
```
To exit the conda console:
```
conda deactivate
```

### To add new libraries and/or packages
First add the library/package to the variable accordingly in file `configuration/reinit.zsh` at the top. <br/>
Then run the script from the "setup" directory:
```
cd setup
./reinit.zsh
```

### To re-create environment with updated environment.yml
If environment.yml has been changed by others, recreate the environment:
```
conda env remove bdat
cd setup
conda env create --name bdat -f environment.yml
```

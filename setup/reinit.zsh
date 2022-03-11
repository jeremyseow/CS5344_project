#!/bin/zsh
# ================================================================================
# variables for conda environment. change only these arguments if need be
# ================================================================================
env_name=bdat
env_file=environment.yml
env_channel=conda-forge
env_libs='python jupyter numpy pandas scikit-learn scipy matplotlib pyspark openjdk Py4J pyarrow'
env_thirdparty='efficient-apriori==2.0.1'
# ================================================================================
# configure environment using variables defined above
# ================================================================================
# required for conda activate and deactivate commands to work in a subshell
source $(conda info --base)/etc/profile.d/conda.sh

# remove and re-create environment
while [[ ${CONDA_DEFAULT_ENV} != "" ]]; do
    echo "deactivating ${CONDA_DEFAULT_ENV}";
    conda deactivate
done
conda env remove --name ${env_name}
conda create -n ${env_name} -c ${env_channel} ${=env_libs}
conda activate ${env_name}
conda env export > ${env_file}
conda deactivate

# add non-conda third party packages
if [[ ${env_thirdparty} != "" ]]; then
    last_line=$(cat ${env_file} | grep -n "^prefix:" | sed -n -e 's/^\([0-9]*\):.*$/\1/p')
    insert_line=$(($last_line-0))
    sed -i '' "${insert_line}i\\
\\
" ${env_file}
    sed -i '' "${insert_line}i\\
  - pip:" ${env_file}
    (IFS=' '; for thirdparty in ${=env_thirdparty}; do
        insert_line=$(($insert_line+1))
        sed -i '' "${insert_line}i\\
\\
" ${env_file}
        sed -i '' "${insert_line}i\\
    - ${thirdparty}" ${env_file}
    done)
fi

# re-create environment using updated environment file
conda env remove --name ${env_name}
conda env create --name ${env_name} -f ${env_file}
conda activate ${env_name}
# ================================================================================

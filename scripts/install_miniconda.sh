#!/bin/bash -
wget -O miniconda.sh http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash miniconda.sh -b -p ~/miniconda
rm miniconda.sh
~/miniconda/bin/conda update --yes conda python

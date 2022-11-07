#!/usr/bin/env bash
# WIP: Install CUDA libraries needed for Tensorflow
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb
dpkg -i cuda-keyring_1.0-1_all.deb
rm cuda-keyring_1.0-1_all.deb
apt-get update
apt-get -y install cuda nvidia-cuda-toolkit nvidia-cudnn

python3 -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

# TODO: fix display driver/CUDA driver mismatch
# 2022-10-30 16:38:24.099543: W tensorflow/stream_executor/platform/default/dso_loader.cc:64] Could not load dynamic library 'libnvinfer.so.7'; dlerror: libnvinfer.so.7: cannot open shared object file: No such file or directory
# 2022-10-30 16:38:24.099594: W tensorflow/stream_executor/platform/default/dso_loader.cc:64] Could not load dynamic library 'libnvinfer_plugin.so.7'; dlerror: libnvinfer_plugin.so.7: cannot open shared object file: No such file or directory
# 2022-10-30 16:38:24.099602: W tensorflow/compiler/tf2tensorrt/utils/py_utils.cc:38] TF-TRT Warning: Cannot dlopen some TensorRT libraries. If you would like to use Nvidia GPU with TensorRT, please make sure the missing libraries mentioned above are installed properly.
# 2022-10-30 16:38:24.977576: E tensorflow/stream_executor/cuda/cuda_driver.cc:265] failed call to cuInit: CUDA_ERROR_SYSTEM_DRIVER_MISMATCH: system has unsupported display driver / cuda driver combination
# 2022-10-30 16:38:24.977603: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:169] retrieving CUDA diagnostic information for host: G7
# 2022-10-30 16:38:24.977609: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:176] hostname: G7
# 2022-10-30 16:38:24.977668: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:200] libcuda reported version is: 510.85.2
# 2022-10-30 16:38:24.977687: I tensorflow/stream_executor/cuda/cuda_diagnostics.cc:204] kernel reported version is: 520.61.5
# 2022-10-30 16:38:24.977694: E tensorflow/stream_executor/cuda/cuda_diagnostics.cc:313] kernel version 520.61.5 does not match DSO version 510.85.2 -- cannot find working devices in this configuration


# For OpenCL
#apt install -y ocl-icd-libopencl1 ocl-icd-dev

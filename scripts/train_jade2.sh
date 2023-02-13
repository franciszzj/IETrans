#!/bin/bash -l
#SBATCH --output=/jmain02/home/J2AD019/exk01/%u/logs/%j.out
#SBATCH --job-name=ietrans
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=5
#SBATCH --ntasks-per-node=1
#SBATCH --time=6-00:00

source ~/.bashrc
module load cuda
nvidia-smi -i $CUDA_VISIBLE_DEVICES
nvcc --version

CMD=$1

sh $CMD
all: FinalProject.cu
	nvcc FinalProject.cu -std=c++11  -I/usr/local/cuda/include -L/usr/local/cuda/lib -lcudart -o FinalProject.exe
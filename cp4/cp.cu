/*
This is the function you need to implement. Quick reference:
- input rows: 0 <= y < ny
- input columns: 0 <= x < nx
- element at row y and column x is stored in data[x + y*nx]
- correlation between rows i and row j has to be stored in result[i + j*ny]
- only parts with 0 <= j <= i < ny need to be filled
*/

#include <cstdlib>
#include <iostream>
#include <cuda_runtime.h>

static inline void check(cudaError_t err, const char *context)
{
    if (err != cudaSuccess)
    {
        std::cerr << "CUDA error: " << context << ": "
                  << cudaGetErrorString(err) << std::endl;
        std::exit(EXIT_FAILURE);
    }
}

#define CHECK(x) check(x, #x)

static inline int divup(int a, int b)
{
    return (a + b - 1) / b;
}

// static inline int roundup(int a, int b)
// {
//     return divup(a, b) * b;
// }

__device__ void foo(int i, int j) {}

__global__ void mykernel(float *result, const float *data, int nx, int ny)
{
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    int j = threadIdx.y + blockIdx.y * blockDim.y;
    if (i >= ny || j >= ny)
    {
        return;
    }
    float dot_product = 0;
    for (int k = 0; k < nx; ++k)
    {
        dot_product += data[k + i * nx] * data[k + j * nx];
    }
    result[i + j * ny] = dot_product;
}

void correlate(int ny, int nx, const float *data, float *result)
{
    float *normalized = new float[ny * nx];

    // Normalize rows to have mean 0
    for (int i = 0; i < ny; ++i)
    {
        float mean = 0;
        for (int j = 0; j < nx; ++j)
        {
            mean += data[j + i * nx];
        }
        mean /= nx;
        for (int j = 0; j < nx; ++j)
        {
            normalized[j + i * nx] = data[j + i * nx] - mean;
        }
    }

    // Normalize rows to have norm of 0
    for (int i = 0; i < ny; ++i)
    {
        float norm = 0;
        for (int j = 0; j < nx; ++j)
        {
            double value = normalized[j + i * nx];
            norm += value * value;
        }
        norm = sqrt(norm);
        for (int j = 0; j < nx; ++j)
        {
            normalized[j + i * nx] /= norm;
        }
    }

    float *dGPU = NULL;
    CHECK(cudaMalloc((void **)&dGPU, nx * ny * sizeof(float)));
    float *rGPU = NULL;
    CHECK(cudaMalloc((void **)&rGPU, ny * ny * sizeof(float)));
    CHECK(cudaMemcpy(dGPU, normalized, nx * ny * sizeof(float), cudaMemcpyHostToDevice));
    // Run kernel
    dim3 dimBlock(16, 16);
    dim3 dimGrid(divup(ny, dimBlock.x), divup(ny, dimBlock.y));
    // std::cout << "dims " << divup(nx, dimBlock.x) << " " << divup(ny, dimBlock.y) << std::endl;
    mykernel<<<dimGrid, dimBlock>>>(rGPU, dGPU, nx, ny);
    CHECK(cudaGetLastError());
    // Copy data back to CPU & release memory
    CHECK(cudaMemcpy(result, rGPU, ny * ny * sizeof(float), cudaMemcpyDeviceToHost));
    CHECK(cudaFree(dGPU));
    CHECK(cudaFree(rGPU));
}
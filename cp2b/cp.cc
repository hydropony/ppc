/*
This is the function you need to implement. Quick reference:
- input rows: 0 <= y < ny
- input columns: 0 <= x < nx
- element at row y and column x is stored in data[x + y*nx]
- correlation between rows i and row j has to be stored in result[i + j*ny]
- only parts with 0 <= j <= i < ny need to be filled
*/
#include <iostream>
#include <math.h>

void correlate(int ny, int nx, const float *data, float *result) {
  // Normalized rows storage
  double *normalized = new double[ny * nx];

  // Normalize rows to have mean 0
  #pragma omp parallel for
  for (int i = 0; i < ny; ++i) {
    double mean = 0;
    for (int j = 0; j < nx; ++j) {
      mean += data[j + i * nx];
    }
    mean /= nx;
    #pragma omp parallel for
    for (int j = 0; j < nx; ++j) {
      normalized[j + i * nx] = data[j + i * nx] - mean;
    }
  }

  // Normalize rows to have norm of 0
  #pragma omp parallel for
  for (int i = 0; i < ny; ++i) {
    double norm = 0;
    for (int j = 0; j < nx; ++j) {
      double value = normalized[j + i * nx];
      norm += value * value;
    }
    norm = sqrt(norm);
    #pragma omp parallel for
    for (int j = 0; j < nx; ++j) {
      normalized[j + i * nx] /= norm;
    }
  }

  // Compute upper triangle of correlation matrix
  #pragma omp parallel for schedule(static, 1)
  for (int i = 0; i < ny; ++i) {
    for (int j = 0; j <= i; ++j) {
      double dot_product = 0;
      for (int k = 0; k < nx; ++k) {
        dot_product += normalized[k + i * nx] * normalized[k + j * nx];
      }
      result[i + j * ny] = dot_product;
    }
  }

  delete[] normalized;
}


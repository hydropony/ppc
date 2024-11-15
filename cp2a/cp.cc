/*
This is the function you need to implement. Quick reference:
- input rows: 0 <= y < ny
- input columns: 0 <= x < nx
- element at row y and column x is stored in data[x + y*nx]
- correlation between rows i and row j has to be stored in result[i + j*ny]
- only parts with 0 <= j <= i < ny need to be filled
*/
#include <math.h>
#include <iostream>

void correlate(int ny, int nx, const float *data, float *result) {
  constexpr int nb = 4;
  int na = (nx + nb - 1) / nb;
  int nab = na*nb;
  double *means = new double[ny];
  for (int row = 0; row < ny; row++) {
    double rowmean = 0;
    for (int x = 0; x < nx; x++) {
      rowmean += data[x + row * nx];
    }
    rowmean /= nx;
    means[row] = rowmean;
  }

  for (int j = 0; j < ny; j++) {
    double meanJ = means[j];

    for (int i = j; i < ny; i++) {
      double meanI = means[i];

      double sumSquaredDiffI = 0;
      double sumSquaredDiffJ = 0;
      double sumProductDiffIJ = 0;
      double diffI[nb];
      double diffJ[nb];
      for (int ka = 0; ka < na; ka++) {
        // double diffIJ[nb];
        for (int kb = 0; kb < nb; kb++) {
          diffI[kb] = data[kb + ka * nb + i * nx] - meanI;
          diffJ[kb] = data[kb + ka * nb + i * nx] - meanJ;
          // diffIJ[kb] = diffI[kb] * diffJ[kb];
          sumSquaredDiffI += diffI[kb] * diffI[kb];
          sumSquaredDiffJ += diffJ[kb] * diffJ[kb];
          sumProductDiffIJ += diffI[kb] * diffJ[kb];
        }
      }
      double corr = sumProductDiffIJ / sqrt(sumSquaredDiffI) / sqrt(sumSquaredDiffJ);
      result[i + j * ny] = corr;
    }
  }
  delete[] means;
  means = nullptr;
}

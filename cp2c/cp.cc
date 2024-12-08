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
#include <vector>
#include <chrono>

typedef double double4_t __attribute__ ((vector_size (4 * sizeof(double))));

static inline double hsum4(double4_t &v) {
  double s = 0;
  for (int i = 0; i < 4; ++i) {
    s += v[i];
  }
  return s;
}

// static inline void subtract4_elementwise(double4_t &v, double a) {
//   for (int i = 0; i < 4; ++i) {
//     v[i] -= a;
//   }
// }

// static inline void divide4_elementwise(double4_t &v, double a) {
//   for (int i = 0; i < 4; ++i) {
//     v[i] /= a;
//   }
// }

static inline double dotproduct4(double4_t a, double4_t b) {
  double4_t mul = a * b;
  return hsum4(mul);
}

static inline double hsumsquares4(double4_t a) {
  double4_t square = a * a;
  return hsum4(square);
}

void correlate(int ny, int nx, const float *data, float *result) {
  // Normalized rows storage
  // double *normalized = new double[ny * nx];
  
  constexpr int nb = 4;
  int na = (nx + nb - 1) / nb;
  std::vector<double4_t> vd(na * ny);
  // std::vector<double4_t> test(2);
  // test[0] = double4_t{1, 1, 1, 1};
  // test[1] = double4_t{2, 2, 2, 2};
  // std::cout << dotproduct4(test[0], test[1]) << std::endl;
  // divide4_elementwise(test[0], 0.1);
  // for (int i = 0; i < nb; ++i) {
  //   std::cout << test[0][i] << " ";
  // }
  // std::cout << std::endl;
 
  // Fill vd
  for (int i = 0; i < ny; ++i) {
    for (int ka = 0; ka < na; ++ka) {
      for (int kb = 0; kb < nb; ++kb) {
        vd[ka + i * na][kb] = (kb + ka * nb) < nx ? data[kb + ka * nb + i * nx] : 0;
      }
    }
  }


  // Normalize rows to have mean 0
  for (int i = 0; i < ny; ++i) {
    double mean = 0;
    for (int ka = 0; ka < na; ++ka) {
      mean += hsum4(vd[ka + i * na]);
    }
    mean /= nx;
    for (int ka = 0; ka < na; ++ka) {
      // subtract4_elementwise(vd[ka + i * na], mean);
      vd[ka + i * na] -= mean;
    }
  }
  
  // Set padding to zero 0 1 2 3 4 5 0 0    6 % 4 = 2
  if (nx % nb != 0) {
    for (int i = 0; i < ny; ++i) {
      for (int kb = nx % nb; kb < nb; ++kb) {
        vd[na - 1 + i * na][kb] = 0;
      }
    }
  }
  // for (int ka = 0; ka < na; ++ka) {
  //   for (int i = 0; i < nb; ++i) {
  //     std::cout << vd[ka + 1][i] << " ";
  //   }
  // }
  // std::cout << std::endl;

  // Normalize rows to have norm of 0
  for (int i = 0; i < ny; ++i) {
    double norm = 0;
    for (int ka = 0; ka < na; ++ka) {
      norm += hsumsquares4(vd[ka + i * na]);
    }
    norm = sqrt(norm);
    for (int ka = 0; ka < na; ++ka) {
      // divide4_elementwise(vd[ka + i * na], norm);
      vd[ka + i * na] /= norm;
    }
  }

  // Compute upper triangle of correlation matrix
  // auto t0 = std::chrono::high_resolution_clock::now();
  for (int i = 0; i < ny; ++i) {
    for (int j = 0; j <= i; ++j) {
      double dot_product = 0;
      for (int ka = 0; ka < na; ka++) {
        dot_product += dotproduct4(vd[ka + i * na], vd[ka + j * na]);
      }
      result[i + j * ny] = dot_product;
    }
  }
  // auto t1 = std::chrono::high_resolution_clock::now();
  // std::cout << "matrix computation took " << (t1-t0).count() << " seconds" << std::endl;

}
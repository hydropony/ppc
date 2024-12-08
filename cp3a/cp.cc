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

static inline double dotproduct4(double4_t &a, double4_t &b) {
  double4_t mul = a * b;
  return hsum4(mul);
}

static inline double hsumsquares4(double4_t a) {
  double4_t square = a * a;
  return hsum4(square);
}

constexpr double4_t d4zeros {0, 0, 0, 0};

void correlate(int ny, int nx, const float *data, float *result) {
  // Normalized rows storage
  // double *normalized = new double[ny * nx];
  
  constexpr int nb = 4; // elements per vector
  int na = (nx + nb - 1) / nb;

  constexpr int hb = 4; // vectors per horizontal strip
  int hb_number = (na + hb - 1) / hb;
  
  constexpr int nd = 3; // rows per block
  int nc = (ny + nd - 1) / nd;
  // std::cout << "nc " << nc << std::endl;
  int ncd = nc * nd; // number of rows after padding
  std::vector<double4_t> vd(na * ncd);

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
  for (int i = 0; i < ncd; ++i) {
    for (int ka = 0; ka < na; ++ka) {
      for (int kb = 0; kb < nb; ++kb) {
        if (i < ny) {
          vd[ka + i * na][kb] = (kb + ka * nb) < nx ? data[kb + ka * nb + i * nx] : 0;
        }
        else {
          vd[ka + i * na][kb] = 0;
        }
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
  // for (int i = 0; i < ny; ++i) {
  //   for (int j = 0; j <= i; ++j) {
  //     double dot_product = 0;
  //     for (int ka = 0; ka < na; ka++) {
  //       dot_product += dotproduct4(vd[ka + i * na], vd[ka + j * na]);
  //     }
  //     result[i + j * ny] = dot_product;
  //   }
  // }
  #pragma omp parallel for schedule(static, 1)
  for (int ic = 0; ic < nc; ++ic) {
    for (int jc = 0; jc <= ic; ++jc) {
      double4_t v[nd][nd] = {d4zeros};
      double4_t vv[nd][nd][hb] = {d4zeros}; 
      for (int ka = 0; ka < hb_number; ++ka) {
        for (int kb = 0; kb < hb; ++kb) {
          asm("# loop starts here");
          if (ka * hb + kb < na) {
            double4_t x0 = vd[na*nd*ic + ka*hb + kb];
            double4_t x1 = vd[na*nd*ic + ka*hb + kb + na];
            double4_t x2 = vd[na*nd*ic + ka*hb + kb + 2 * na];

            double4_t y0 = vd[na*nd*jc + ka*hb + kb];
            double4_t y1 = vd[na*nd*jc + ka*hb + kb + na];
            double4_t y2 = vd[na*nd*jc + ka*hb + kb + 2 * na];

            vv[0][0][kb] += x0 * y0;
            vv[0][1][kb] += x0 * y1;
            vv[0][2][kb] += x0 * y2;
            vv[1][0][kb] += x1 * y0;
            vv[1][1][kb] += x1 * y1;
            vv[1][2][kb] += x1 * y2;
            vv[2][0][kb] += x2 * y0;
            vv[2][1][kb] += x2 * y1;
            vv[2][2][kb] += x2 * y2;
          }
          asm("# loop ends here");
        }
      }
      for (int id = 0; id < nd; ++id) {
        for (int jd = 0; jd < nd; ++jd) {
          for (int kb = 0; kb < hb; ++kb) {
            v[id][jd] += vv[id][jd][kb];
          }
        }
      }
      // std::cout << "vv2 " << vv[2][2] << std::endl;
      for (int id = 0; id < nd; ++id) {
        for (int jd = 0; jd < nd; ++jd) {
          int j = ic * nd + id;
          int i = jc * nd + jd;
          // std::cout << i << " " << j << std::endl;
          if (i < ny && j < ny) {
            result[j + i * ny] = hsum4(v[id][jd]);
          }
        }
      }
    }
  }
  
  // auto t1 = std::chrono::high_resolution_clock::now();
  // std::cout << "matrix computation took " << (t1-t0).count() << " seconds" << std::endl;

}

// instruction-level parallelism 
// multithreading: DONE 
// vector instructions: DONE
// memory access optimization: DONE
/*
This is the function you need to implement. Quick reference:
- input rows: 0 <= y < ny
- input columns: 0 <= x < nx
- element at row y and column x is stored in in[x + y*nx]
- for each pixel (x, y), store the median of the pixels (a, b) which satisfy
  max(x-hx, 0) <= a < min(x+hx+1, nx), max(y-hy, 0) <= b < min(y+hy+1, ny)
  in out[x + y*nx].
*/
#include <algorithm>
#include <vector>
#include <functional>

float quickselect(std::vector<float> &arr, int size, int k) {
    std::vector<float> a = arr;
    std::nth_element(a.begin(), a.begin() + k, a.end(), std::greater<float>());
    return a[k];
}

void mf(int ny, int nx, int hy, int hx, const float *in, float *out) {
  for (int y = 0; y < ny; ++y) {
    for (int x = 0; x < nx; ++x) {
      std::vector<float> acc;
      int size = 0;
      for (int yy = std::max(0, y - hy); yy < std::min(y+hy+1, ny); ++yy) {
        for (int xx = std::max(0, x - hx); xx < std::min(x+hx+1, nx); ++xx) {
          acc.push_back(in[yy * nx + xx]);
          size += 1;
        }
      }
      if (size % 2 == 1) {
        out[x + y * nx] = quickselect(acc, size, size / 2);
      }
      else {
        out[x + y * nx] = (quickselect(acc, size, size / 2) + quickselect(acc, size, size / 2 - 1)) / 2;
      }
    }
  }
}

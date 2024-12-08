#include <algorithm>
#include <omp.h>
#include <vector>
#include <iostream>
#include <chrono>

typedef unsigned long long data_t;

typedef float data4_t __attribute__ ((vector_size (4 * sizeof(data_t))));

// std::chrono::nanoseconds total(0);

void merge(data_t* data, data_t* copy, int left, int mid, int right) {
    
    int n1 = mid - left + 1;
    int n2 = right - mid;

    // std::vector<data_t> L(n1), R(n2);

    // auto start = std::chrono::high_resolution_clock::now();
    // for (int i = 0; i < n1; i++)
    //     L[i] = data[left + i];
    // for (int i = 0; i < n2; i++)
    //     R[i] = data[mid + 1 + i];
    // auto end = std::chrono::high_resolution_clock::now();        
    
    
    // int i = 0, j = 0, k = left;
    // while (i < n1 && j < n2) {
    //     if (L[i] <= R[j]) {
    //         data[k++] = L[i++];
    //     } else {
    //         data[k++] = R[j++];
    //     }
    // }
    
    // while (i < n1) {
    //     data[k++] = L[i++];
    // }

    // while (j < n2) {
    //     data[k++] = R[j++];
    // }
    int i = 0, j = 0, k = left;
    while (i < n1 && j < n2) {
        if (copy[left + i] <= copy[mid + 1 + j]) {
            data[k++] = copy[left + i++];
        } else {
            data[k++] = copy[mid + 1 + j++];
        }
    }
    
    while (i < n1) {
        data[k++] = copy[left + i++];
    }

    while (j < n2) {
        data[k++] = copy[mid + 1 + j++];
    }
    
    // total += std::chrono::duration_cast<std::chrono::nanoseconds>(end - start);

}

void printdata(int n, data_t *data) {
    for (int i = 0; i < n; ++i) {
        std::cout << data[i] << " ";
    }
    std::cout << std::endl;
}

void psort(int n, data_t* data) {
    // auto start = std::chrono::high_resolution_clock::now();
    // int p = omp_get_max_threads();
    // std::cout << p << std::endl;
    data_t* copy = new data_t[n];

    int chunk_size = n / 1000 + 1;
    #pragma omp parallel for schedule(dynamic, 1)
    for (int i = 0; i < n; i += chunk_size) {
        int chunk_end = std::min(i + chunk_size, n);
        std::sort(data + i, data + chunk_end);
    }


    for (int width = chunk_size; width < n; width *= 2) {
        #pragma omp parallel for
        for (int i = 0; i < n; ++i) {
            copy[i] = data[i];
        }
        #pragma omp parallel for
        for (int i = 0; i < n; i += 2 * width) {
            int left = i;
            int middle = std::min(i + width - 1, n - 1);
            int right = std::min(i + 2 * width - 1, n - 1);
            
            merge(data, copy, left, middle, right);
            // printdata(n, data);
        }
    }
    delete[] copy;
    // std::sort(data, data+n);
    // auto end = std::chrono::high_resolution_clock::now();
    // auto el = std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count();
    // std::cout << "elapsed " << std::chrono::duration_cast<std::chrono::milliseconds>(total).count() << std::endl;
}
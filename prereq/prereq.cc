struct Result {
    float avg[3];
};

/*
This is the function you need to implement. Quick reference:
- x coordinates: 0 <= x < nx
- y coordinates: 0 <= y < ny
- horizontal position: 0 <= x0 < x1 <= nx
- vertical position: 0 <= y0 < y1 <= ny
- color components: 0 <= c < 3
- input: data[c + 3 * x + 3 * nx * y]
- output: avg[c]
*/
Result calculate(int ny, int nx, const float *data, int y0, int x0, int y1, int x1) {
    double avg[3] = {0,0,0};
    int cnt = 0;
    for (int currY = y0; currY < y1; currY++) {
        for (int currX = x0; currX < x1; currX++) {
            for (int color = 0; color < 3; color++) {
                avg[color] += data[color + 3 * currX + 3 * nx * currY];
            }
            cnt++;
        }
    }
    for (int color = 0; color < 3; color++) {
        avg[color] /= cnt;
    }
    Result result({(float)avg[0], (float)avg[1], (float)avg[2]});
    return result;
}

#include <stdio.h>
#include <chrono>
#include <ctime>
#include <math.h>
#include <random>
#include <iostream>
#include <vector>


__global__ 
void solvePerceptron(double* weight1, double* weight2, double* weight3, double* weight4, double* b, double* throughput1, double* throughput2, double* throughput3, double* throughput4, double* out) {
    int id = blockIdx.x*blockDim.x+threadIdx.x;
    double weightFunc = weight1[id]*throughput1[id] + weight2[id]*throughput2[id] + weight3[id]*throughput3[id] + weight4[id]*throughput4[id] + b[id];
    out[id] = 1/(1+exp(-weightFunc));
}

double calcDeltak(double yj, double yk, double dk, double wkj) {
    return yk*(1-yk)*(dk-yk);
}

double calcDeltaj(double yj, double yk, double dk, double wkj, double deltak) {
    return yj*(1-yj)*wkj*deltak;
}

double updateWeight(double w, double x_or_y, double eta, double delta) {
    return w+eta*delta*x_or_y;
}

int runIterations(double eta, double* possible_inputs, double* input_ans, double* error, double* weights1, double* weights2, double* weights3, double* weights4, double* layer2_weights, double* bias, double* layer2Bias) {
    double error_max = 1;
    std::vector<int> iteration_vector;
    double layer2Per = 0;
    //TODO: Send weights to CUDA GPU
    for (int i=1; i<16; ++i) iteration_vector.push_back(i);
    while (error_max > .05) {
        //Randomize order of input
        std::random_shuffle ( iteration_vector.begin(), iteration_vector.end() );
        for(int i = 0; i < iteration_vecotr.size(); i++) {
            //TODO: Solve Perceptrons Layer using CUDA Simutaneously
            //TODO: Calc Deltas
            //TODO: Update Weights
            //Calc Error for current input
            error[iteration_vector[i]] = input_ans[iteration_vector[i]]-layer2Per;
        }
        //TODO: CALC Max Error After iterations
    }
    return 0;
}

double* generateWeights(int numWeights) {
    double* weights = (double*)calloc(numWeights, sizeof(double));
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<> dis(-1.0, 1.0);
    for(int i = 0; i < numWeights; i++) {
        weights[i] = dis(gen);
    }
    return weights;
}

int main(int argc, char** argv)
{
    double* weights1 = generateWeights(4);
    double* weights2 = generateWeights(4);
    double* weights3 = generateWeights(4);
    double* weights4 = generateWeights(4);
    double* layer2_weights = generateWeights(4);
                                               
    double* bias = generateWeights(4);
                                               
    double* layer2Bias = generateWeights(1);
                                               
    double error [16] = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
                                               
    double eta = .5;
                                               
    double possible_inputs[16][4] = {{0,0,0,0}, {0,0,0,1}, {0,0,1,0}, {0,0,1,1}, {0,1,0,0}, {0,1,0,1}, {0,1,1,0}, {0,1,1,1}, {1,0,0,0}, {1,0,0,1}, {1,0,1,0}, {1,0,1,1}, {1,1,0,0}, {1,1,0,1}, {1,1,1,0}, {1,1,1,1}};
                                               
    double input_ans[16] = {0,1,1,0,1,0,0,1,1,0,0,1,0,1,1,0};
    
    return 0;
}
#!/bin/bash

# the script accepts one argument to indidate the output file where the perf results are appended to. 
# e.g., ./run.sh perf-result-file
chmod +x ./h264dec #giving access permissions to the benchmark file
gcc viraj.c -o viraj -lpthread #compiling the clear cache c code
for (( i=1; i<4; i++ )); # running 3 iterations for the entire benchmark
do 
	echo "Iteration no: $i">>results.txt

	echo "Running without Hyperthreading">>results.txt

	taskset -c 4 ./viraj
	echo "=== test run with 1 threads ===">>results.txt  
	taskset -c 4 perf stat -e L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 1
	taskset -c 4 ./viraj
	taskset -c 4 perf stat -e cpu-cycles,instructions,r2124,rE124 -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 1

	taskset -c 4,1 ./viraj
	echo "=== test run with 2 threads ===">>results.txt  
	taskset -c 4,1 perf stat -e L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 2
	taskset -c 4,1 ./viraj
	taskset -c 4,1 perf stat -e cpu-cycles,instructions,r2124,rE124 -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 2

	taskset -c 4,1,3,6 ./viraj
	echo "=== test run with 4 threads ===">>results.txt
	taskset -c 4,1,3,6 perf stat -e L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 4
	taskset -c 4,1,3,6 ./viraj
	taskset -c 4,1,3,6 perf stat -e cpu-cycles,instructions,r2124,rE124 -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 4

	taskset -c 4,1,3,2,5,6,7,0 ./viraj
	echo "=== test run with 8 threads ===">>results.txt  
	taskset -c 4,1,3,2,5,6,7,0 perf stat -e L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 8
	taskset -c 4,1,3,2,5,6,7,0 ./viraj 
	taskset -c 4,1,3,2,5,6,7,0 perf stat -e cpu-cycles,instructions,r2124,rE124 -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 8


	echo "Running with Hyperthreading">>results.txt  

	taskset -c 4,10 ./viraj
	echo "=== test run with 2 threads ===">>results.txt  
	taskset -c 4,10 perf stat -e L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 2
	taskset -c 4,10 ./viraj
	taskset -c 4,10 perf stat -e cpu-cycles,instructions,r2124,rE124 -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 2

	taskset -c 4,10,3,13 ./viraj
	echo "=== test run with 4 threads ===">>results.txt  
	taskset -c 4,10,3,13 perf stat -e L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 4
	taskset -c 4,10,3,13 ./viraj
	taskset -c 4,10,3,13 perf stat -e cpu-cycles,instructions,r2124,rE124 -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 4

	taskset -c 4,10,3,13,8,18,9,19 ./viraj
	echo "=== test run with 8 threads ===">>results.txt
	taskset -c 4,10,3,13,8,18,9,19 perf stat -e L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 8
	taskset -c 4,10,3,13,8,18,9,19 ./viraj
	taskset -c 4,10,3,13,8,18,9,19 perf stat -e cpu-cycles,instructions,r2124,rE124 -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 8

	taskset -c 4,10,12,2,5,15,7,17,3,13,6,16,8,18,9,19 ./viraj
	echo "=== test run with 16 threads ===">>results.txt  
	taskset -c 4,10,12,2,5,15,7,17,3,13,6,16,8,18,9,19 perf stat -e L1-dcache-loads,L1-dcache-load-misses,LLC-loads,LLC-load-misses -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 16
	taskset -c 4,10,12,2,5,15,7,17,3,13,6,16,8,18,9,19 ./viraj
	taskset -c 4,10,12,2,5,15,7,17,3,13,6,16,8,18,9,19 perf stat -e cpu-cycles,instructions,r2124,rE124 -o results.txt --append ./h264dec -i ./park_joy_2160p.h264 -t 16

done

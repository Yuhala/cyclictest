#!/bin/bash
data="nuc_ctest_1h_native_no_stress.log"


max=`grep "Max Latencies" $data | tr " " "\n" | sort -n | tail -1 | sed s/^0*//`
grep -v -e "^#" -e "^$" $data | tr " " "\t" >histogram 
cores=4

for i in `seq 1 $cores`
do
  column=`expr $i + 1`
  cut -f1,$column histogram >histogram$i
done

echo -n -e "set title \"Latency plot\"\n\
set terminal png\n\
set xlabel \"Latency (us), max $max us\"\n\
set logscale y\n\
set xrange [0:400]\n\
set yrange [0.8:*]\n\
set ylabel \"Number of latency samples\"\n\
set output \"ctest.png\"\n\
plot " >plotcmd

for i in `seq 1 $cores`
do
  if test $i != 1
  then
    echo -n ", " >>plotcmd
  fi
  cpuno=`expr $i - 1`
  if test $cpuno -lt 10
  then
    title=" CPU$cpuno"
   else
    title="CPU$cpuno"
  fi
  echo -n "\"histogram$i\" using 1:2 title \"$title\" with histeps" >>plotcmd
done

gnuplot -persist <plotcmd
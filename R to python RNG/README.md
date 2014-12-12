r_rng.py

======
written by Jon Atwell
======

A simple module that uses the RPY2 module to overwrite the main
methods of the RANDOM module. This facilitates the use of the 
same random number generator in models written in R and Python 
for docking proposes. Nota Bene: Some of the native sampling 
functions in R are very succinct and request numbers less frequently 
than a custom Python function would so you might need to rewrite the 
R script to make sure it queries the random number generator the same 
number of times.

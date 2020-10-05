# Project title

I created this module to benchmark different container types, optimizers and optimization settings using JuMP.

# Motivation

I just started using Julia/JuMP a few weeks ago and will have to use it to create and optimize linear models. Because I do not know which container types are the best for the optimization variables, coefficients and constraints respectively, which of the optimizers work the best and in general which options I should use, I have created some modules to help me perform benchmarks and save them in a readable form.

# Src

The ModelBuilds.jl contains several functions where in each a JuMP model is built with several possible modifications.

The TestManager.jl is the central piece of code where the different ModelBuilds get called and benchmarked.

The TestSpecDef.jl contains the definition of the struct TestSpec, which contains all possible specifiactions for a benchmarking run.

The HelperFunctions.jl just contains several helper functions to convert the data to more readable formats and a function that contains an interface to excel.

The DataCreator.jl contains functions to create the coefficients that are used when formulating the constraints of the optimization models. Using this function you ensure that all models use the same data that is stored as different data types.

# Example

The example folder contains a subfolder where the data is stored and a subfolder where the results are saved.
Furthermore there is an Example.jl that shows how the TestManager.jl gets used to create and save the benchmarks.
push!(LOAD_PATH,".")

using TestManager, TestSpecDef, JuMP, JLD, Dictionaries, NamedDims


maxSeconds = 30
maxSamples = 1000


testSpec1 = TestSpec(A,1,maxSeconds,maxSamples,"Data/arrayData1000.jld",false,false,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","D10",1)
testSpec2 = TestSpec(A,2,maxSeconds,maxSamples,"Data/arrayData1000.jld",false,true,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","F10",1)

testSpec3 = TestSpec(AL,1,maxSeconds,maxSamples,"Data/arrayData1000.jld",false,false,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","D16",1)
testSpec4 = TestSpec(AL,2,maxSeconds,maxSamples,"Data/arrayData1000.jld",false,true,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","F16",1)

testSpec5 = TestSpec(ALB,1,maxSeconds,maxSamples,"Data/arrayData1000.jld",false,false,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","D22",1)
testSpec6 = TestSpec(ALB,2,maxSeconds,maxSamples,"Data/arrayData1000.jld",false,true,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","F22",1)

testSpec7 = TestSpec(DAA,1,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,false,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","D28",1)
testSpec8 = TestSpec(DAA,2,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,true,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","F28",1)

testSpec9 = TestSpec(DAAL,1,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,false,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","D34",1)
testSpec10 = TestSpec(DAAL,2,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,true,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","F34",1)

testSpec11 = TestSpec(DAALS,1,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,false,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","D40",1)
testSpec12 = TestSpec(DAALS,2,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,true,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","F40",1)

testSpec13 = TestSpec(DAALB,1,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,false,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","D46",1)
testSpec14 = TestSpec(DAALB,2,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,true,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","F46",1)

testSpec15 = TestSpec(DAAS20,1,maxSeconds,maxSamples,"Data/denseAxisArrayDataStr1000.jld",false,false,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","D52",1)
testSpec16 = TestSpec(DAAS20,2,maxSeconds,maxSamples,"Data/denseAxisArrayDataStr1000.jld",false,true,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","F52",1)

testSpec17 = TestSpec(D,1,maxSeconds,maxSamples,"Data/dictData1000.jld",false,false,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","D58",1)
testSpec18 = TestSpec(D,2,maxSeconds,maxSamples,"Data/dictData1000.jld",false,true,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","F58",1)

testSpec19 = TestSpec(DD,1,maxSeconds,maxSamples,"Data/dictionaryData1000.jld",false,false,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","D64",1)
testSpec20 = TestSpec(DD,2,maxSeconds,maxSamples,"Data/dictionaryData1000.jld",false,true,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","F64",1)

testSpec21 = TestSpec(ND,1,maxSeconds,maxSamples,"Data/namedDimsData1000.jld",false,false,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","D70",1)
testSpec22 = TestSpec(ND,2,maxSeconds,maxSamples,"Data/namedDimsData1000.jld",false,true,true,true,"Results/Excel/DatatypeBenchmarks2.xlsx","F70",1)

#testSpecs = [testSpec1 testSpec2 testSpec3 testSpec4 testSpec5 testSpec6 testSpec7 testSpec8 testSpec9 testSpec10 testSpec11 testSpec12 testSpec13 testSpec14 testSpec15 testSpec16 testSpec17 testSpec18 testSpec19 testSpec20 testSpec21 testSpec22]
testSpecs = [testSpec11 testSpec12 testSpec13 testSpec14 testSpec15 testSpec16 testSpec17 testSpec18 testSpec19 testSpec20 testSpec21 testSpec22]
for testSpec in testSpecs
   Test(testSpec)
end
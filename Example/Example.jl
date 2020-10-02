push!(LOAD_PATH,".")
using TestManager, JuMP, JLD, Dictionaries, NamedDims


maxSeconds = 30
maxSamples = 1000

excelDir = "Results/Excel/DatatypeBenchmarks.xlsx"

testSpec1 = TestSpec(A,1,maxSeconds,maxSamples,"Data/arrayData1000.jld",false,false,true,true,excelDir,"D10",1,false)
testSpec2 = TestSpec(A,2,maxSeconds,maxSamples,"Data/arrayData1000.jld",false,true,true,true,excelDir,"F10",1,false)

testSpec3 = TestSpec(AL,1,maxSeconds,maxSamples,"Data/arrayData1000.jld",false,false,true,true,excelDir,"D16",1,false)
testSpec4 = TestSpec(AL,2,maxSeconds,maxSamples,"Data/arrayData1000.jld",false,true,true,true,excelDir,"F16",1,false)

testSpec5 = TestSpec(ALB,1,maxSeconds,maxSamples,"Data/arrayData1000.jld",false,false,true,true,excelDir,"D22",1,false)
testSpec6 = TestSpec(ALB,2,maxSeconds,maxSamples,"Data/arrayData1000.jld",false,true,true,true,excelDir,"F22",1,false)

testSpec7 = TestSpec(DAA,1,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,false,true,true,excelDir,"D28",1,false)
testSpec8 = TestSpec(DAA,2,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,true,true,true,excelDir,"F28",1,false)

testSpec9 = TestSpec(DAAL,1,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,false,true,true,excelDir,"D34",1,false)
testSpec10 = TestSpec(DAAL,2,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,true,true,true,excelDir,"F34",1,false)

testSpec11 = TestSpec(DAALS,1,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,false,true,true,excelDir,"D40",1,false)
testSpec12 = TestSpec(DAALS,2,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,true,true,true,excelDir,"F40",1,false)

testSpec13 = TestSpec(DAALB,1,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,false,true,true,excelDir,"D46",1,false)
testSpec14 = TestSpec(DAALB,2,maxSeconds,maxSamples,"Data/denseAxisArrayData1000.jld",false,true,true,true,excelDir,"F46",1,false)

testSpec15 = TestSpec(DAAS20,1,maxSeconds,maxSamples,"Data/denseAxisArrayDataStr1000.jld",false,false,true,true,excelDir,"D52",1,false)
testSpec16 = TestSpec(DAAS20,2,maxSeconds,maxSamples,"Data/denseAxisArrayDataStr1000.jld",false,true,true,true,excelDir,"F52",1,false)

testSpec17 = TestSpec(D,1,maxSeconds,maxSamples,"Data/dictData1000.jld",false,false,true,true,excelDir,"D58",1,false)
testSpec18 = TestSpec(D,2,maxSeconds,maxSamples,"Data/dictData1000.jld",false,true,true,true,excelDir,"F58",1,false)

testSpec19 = TestSpec(DD,1,maxSeconds,maxSamples,"Data/dictionaryData1000.jld",false,false,true,true,excelDir,"D64",1,false)
testSpec20 = TestSpec(DD,2,maxSeconds,maxSamples,"Data/dictionaryData1000.jld",false,true,true,true,excelDir,"F64",1,false)

testSpec21 = TestSpec(ND,1,maxSeconds,maxSamples,"Data/namedDimsData1000.jld",false,false,true,true,excelDir,"D70",1,false)
testSpec22 = TestSpec(ND,2,maxSeconds,maxSamples,"Data/namedDimsData1000.jld",false,true,true,true,excelDir,"F70",1,false)

testSpecs = [testSpec1 testSpec2 testSpec3 testSpec4 testSpec5 testSpec6 testSpec7 testSpec8 testSpec9 testSpec10 testSpec11 testSpec12 testSpec13 testSpec14 testSpec15 testSpec16 testSpec17 testSpec18 testSpec19 testSpec20 testSpec21 testSpec22]

for testSpec in testSpecs
   Test(testSpec)
end
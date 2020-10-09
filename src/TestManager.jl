module TestManager

using ModelBuilds, HelperFunctions, TestSpecDef, JuMP, BenchmarkTools, Profile, JLD

export Test

function Test(testSpec::TestSpec)
    dataTypeID = testSpec.dataTypeID
    problemNbr = testSpec.problemNbr

	# set default time and number of samples for benchmarking process
	BenchmarkTools.DEFAULT_PARAMETERS.seconds = testSpec.benchMarkSeconds
	BenchmarkTools.DEFAULT_PARAMETERS.samples = testSpec.benchMarkSamples

    dataDict = load(testSpec.dataDict)
    n = dataDict["n"]
    coeff = dataDict["arrayCoeff"]
    bound = dataDict["arrayBound"]

    if dataTypeID in [DAAS20 DS]
        str_con = dataDict["str_con"]
        str_obj = dataDict["str_obj"]
    end

    directMode = testSpec.directMode
    optimization = testSpec.optimization
    writeToLp = testSpec.writeToLpFile
    LpFile = string("Results/LpFiles/" , string(dataTypeID) ,"/", string(dataTypeID) ,"_", problemNbr ,".lp")
    writeToExcel = testSpec.writeToExcel
    excelFile = testSpec.excelFile
    excelLocation = testSpec.excelLocation
    sheetNbr = testSpec.sheetNbr
    writeProfileLog = testSpec.writeProfileLog
    objValue = 0.0
    optimizer = testSpec.optimizer

    println("Start Test")

    if writeToLp == true
        if dataTypeID == A
            model = arrayModel(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == AL
            model = arrayModelLongName(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == ALB
            model = arrayModelLongBasename(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == DAA
            model = denseAxisArrayModel(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == DAAL
            model = denseAxisArrayModelLongName(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == DAALS
            model = denseAxisArrayModelLongNameShortBasename(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == DAALB
            model = denseAxisArrayModelLongBasename(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == DAAS20
            model = denseAxisArrayModelStr20(coeff, bound, str_obj, str_con, directMode, optimization)
        elseif dataTypeID == D
            model = dictModel(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == DS
            model = dictModelStr(coeff, bound, str_obj, str_con, directMode, optimization)
        elseif dataTypeID == DD
            model = dictionaryModel(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == ND
            model = namedDimsModel(coeff, bound, n, directMode, optimization)
        end

        JuMP.write_to_file(model, LpFile)
        
        if optimization == true
            objValue = JuMP.objective_value(model)
        end

        empty!(model)
        println(".lp file was saved succesfully")
    end

    if writeToExcel == true
        
        println("benchmarking started")
        #first without saving values

        #save in every case only the second benchmark
        if dataTypeID == A
            @benchmark arrayModel($coeff, $bound, $n, $directMode, $optimization, $optimizer)
            benchmark = @benchmark arrayModel($coeff, $bound, $n, $directMode, $optimization, $optimizer) 
        elseif dataTypeID == AL
            @benchmark arrayModelLongName($coeff, $bound, $n, $directMode, $optimization, $optimizer)
            benchmark = @benchmark arrayModelLongName($coeff, $bound, $n, $directMode, $optimization, $optimizer)
        elseif dataTypeID == ALB
            @benchmark arrayModelLongBasename($coeff, $bound, $n, $directMode, $optimization, $optimizer)
            benchmark = @benchmark arrayModelLongBasename($coeff, $bound, $n, $directMode, $optimization, $optimizer)
        elseif dataTypeID == DAA
            @benchmark denseAxisArrayModel($coeff, $bound, $n, $directMode, $optimization, $optimizer)
            benchmark = @benchmark denseAxisArrayModel($coeff, $bound, $n, $directMode, $optimization, $optimizer)
        elseif dataTypeID == DAAL
            @benchmark denseAxisArrayModelLongName($coeff, $bound, $n, $directMode, $optimization, $optimizer)
            benchmark = @benchmark denseAxisArrayModelLongName($coeff, $bound, $n, $directMode, $optimization, $optimizer)
        elseif dataTypeID == DAALS
            @benchmark denseAxisArrayModelLongNameShortBasename($coeff, $bound, $n, $directMode, $optimization, $optimizer)
            benchmark = @benchmark denseAxisArrayModelLongNameShortBasename($coeff, $bound, $n, $directMode, $optimization, $optimizer)
        elseif dataTypeID == DAALB
            @benchmark denseAxisArrayModelLongBasename($coeff, $bound, $n, $directMode, $optimization, $optimizer)
            benchmark = @benchmark denseAxisArrayModelLongBasename($coeff, $bound, $n, $directMode, $optimization, $optimizer)
        elseif dataTypeID == DAAS20
            @benchmark denseAxisArrayModelStr20($coeff, $bound, $str_obj, $str_con, $directMode, $optimization, $optimizer)
            benchmark = @benchmark denseAxisArrayModelStr20($coeff, $bound, $str_obj, $str_con, $directMode, $optimization, $optimizer)
        elseif dataTypeID == D
            @benchmark dictModel($coeff, $bound, $n, $directMode, $optimization, $optimizer)
            benchmark = @benchmark dictModel($coeff, $bound, $n, $directMode, $optimization, $optimizer)
        elseif dataTypeID == DS
            @benchmark dictModelStr($coeff, $bound, $str_obj, $str_con, $directMode, $optimization, $optimizer)
            benchmark = @benchmark dictModelStr($coeff, $bound, $str_obj, $str_con, $directMode, $optimization, $optimizer)
        elseif dataTypeID == DD
            @benchmark dictionaryModel($coeff, $bound, $n, $directMode, $optimization, $optimizer)
            benchmark = @benchmark dictionaryModel($coeff, $bound, $n, $directMode, $optimization, $optimizer)
        elseif dataTypeID == ND
            @benchmark namedDimsModel($coeff, $bound, $n, $directMode, $optimization, $optimizer)
            benchmark = @benchmark namedDimsModel($coeff, $bound, $n, $directMode, $optimization, $optimizer)
        end


        println("benchmarking finished")
		#location specifices where to save the benchmark in the excel file
		#save the benchmark in the excel file
		benchmarkToExcel(excelFile, sheetNbr, benchmark, excelLocation, objValue)      
        println("excel file was saved succesfully") 
    end
end

end
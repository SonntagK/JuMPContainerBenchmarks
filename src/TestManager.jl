module TestManager

using ModelBuilds, HelperFunctions, JuMP, BenchmarkTools, Profile, JLD

export TestSpec, Test, dataType, A, AL, ALB, DAA, DAAL, DAALS, DAALB, DAAS20, D, DS, DD, ND

@enum dataType A AL ALB DAA DAAL DAALS DAALB DAAS20 D DS DD ND

struct  TestSpec
    dataTypeID::dataType
    problemNbr::Int
    benchMarkSeconds::Int
    benchMarkSamples::Int
    dataDict::String
    directMode::Bool
    optimization::Bool
    writeToLpFile::Bool
    writeToExcel::Bool
    excelFile::String
    excelLocation::String
    sheetNbr::Int
    writeProfileLog::Bool
end

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

    if writeProfileLog == true
        Profile.clear()
        
        if dataTypeID == A
            @profile arrayModel(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == AL
            @profile arrayModelLongName(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == ALB
            @profile arrayModelLongBasename(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == DAA
            @profile denseAxisArrayModel(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == DAAL
            @profile denseAxisArrayModelLongName(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == DAALS
            @profile denseAxisArrayModelLongNameShortBasename(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == DAALB
            @profile denseAxisArrayModelLongBasename(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == DAAS20
            @profile denseAxisArrayModelStr20(coeff, bound, str_obj, str_con, directMode, optimization)
        elseif dataTypeID == D
            @profile dictModel(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == DS
            @profile dictModelStr(coeff, bound, str_obj, str_con, directMode, optimization)
        elseif dataTypeID == DD
            @profile dictionaryModel(coeff, bound, n, directMode, optimization)
        elseif dataTypeID == ND
            @profile namedDimsModel(coeff, bound, n, directMode, optimization)
        end

        profileDir =  string("Results/ProfileLogs/", string(dataTypeID) ,"/", string(dataTypeID) ,"_", problemNbr ,".txt")
		open(Profile.print, profileDir, "w")
        Profile.init()
        
        println("profile log was saved succesfully")
    end

    if writeToExcel == true
        
        println("benchmarking started")
        #first without saving values

        #save in every case only the second benchmark
        if dataTypeID == A
            @benchmark arrayModel($coeff, $bound, $n, $directMode, $optimization)
            benchmark = @benchmark arrayModel($coeff, $bound, $n, $directMode, $optimization) 
        elseif dataTypeID == AL
            @benchmark arrayModelLongName($coeff, $bound, $n, $directMode, $optimization)
            benchmark = @benchmark arrayModelLongName($coeff, $bound, $n, $directMode, $optimization)
        elseif dataTypeID == ALB
            @benchmark arrayModelLongBasename($coeff, $bound, $n, $directMode, $optimization)
            benchmark = @benchmark arrayModelLongBasename($coeff, $bound, $n, $directMode, $optimization)
        elseif dataTypeID == DAA
            @benchmark denseAxisArrayModel($coeff, $bound, $n, $directMode, $optimization)
            benchmark = @benchmark denseAxisArrayModel($coeff, $bound, $n, $directMode, $optimization)
        elseif dataTypeID == DAAL
            @benchmark denseAxisArrayModelLongName($coeff, $bound, $n, $directMode, $optimization)
            benchmark = @benchmark denseAxisArrayModelLongName($coeff, $bound, $n, $directMode, $optimization)
        elseif dataTypeID == DAALS
            @benchmark denseAxisArrayModelLongNameShortBasename($coeff, $bound, $n, $directMode, $optimization)
            benchmark = @benchmark denseAxisArrayModelLongNameShortBasename($coeff, $bound, $n, $directMode, $optimization)
        elseif dataTypeID == DAALB
            @benchmark denseAxisArrayModelLongBasename($coeff, $bound, $n, $directMode, $optimization)
            benchmark = @benchmark denseAxisArrayModelLongBasename($coeff, $bound, $n, $directMode, $optimization)
        elseif dataTypeID == DAAS20
            @benchmark denseAxisArrayModelStr20($coeff, $bound, $str_obj, $str_con, $directMode, $optimization)
            benchmark = @benchmark denseAxisArrayModelStr20($coeff, $bound, $str_obj, $str_con, $directMode, $optimization)
        elseif dataTypeID == D
            @benchmark dictModel($coeff, $bound, $n, $directMode, $optimization)
            benchmark = @benchmark dictModel($coeff, $bound, $n, $directMode, $optimization)
        elseif dataTypeID == DS
            @benchmark dictModelStr($coeff, $bound, $str_obj, $str_con, $directMode, $optimization)
            benchmark = @benchmark dictModelStr($coeff, $bound, $str_obj, $str_con, $directMode, $optimization)
        elseif dataTypeID == DD
            @benchmark dictionaryModel($coeff, $bound, $n, $directMode, $optimization)
            benchmark = @benchmark dictionaryModel($coeff, $bound, $n, $directMode, $optimization)
        elseif dataTypeID == ND
            @benchmark namedDimsModel($coeff, $bound, $n, $directMode, $optimization)
            benchmark = @benchmark namedDimsModel($coeff, $bound, $n, $directMode, $optimization)
        end


        println("benchmarking finished")
		#location specifices where to save the benchmark in the excel file
		#save the benchmark in the excel file
		benchmarkToExcel(excelFile, sheetNbr, benchmark, excelLocation, objValue)      
        println("excel file was saved succesfully") 
    end
end

end
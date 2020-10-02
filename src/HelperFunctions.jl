module HelperFunctions

using XLSX

export benchmarkToExcel

# this array of strings is used to navigate in the excel file using XLSX
const excelXLocation = ["D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","AA","AB","AC","AD","AE","AF","AG","AH","AI","AJ","AK","AL","AM","AN","AO","AP","AQ","AR","AS","AT","AU","AV","AW","AX","AY","AZ"];
#file to handle benchmarkin process for arbitrary model


# helper functions to transfer memory from bytes to better readable form as in the @benachmark output
# e.g. "11.49 GiB" = helperMemoryEst(12345678910)
function helperMemoryEst(memory::Int)
	
	strDim = ["B", "KiB", "MeB", "GiB", "TeB", "PeB", "ExB", "ZeB"] 
	countDim = 1

	while (memory >= 1024 && countDim < 9)
        memory = memory/1024
		countDim = countDim + 1
	end

	#strMemory = string(memory)
	#len = length(strMemory)
	#strMemory = string(strMemory[1:min(len,5)], " ",strDim[countDim])

	return memory, strDim[countDim]
end

# helper functions to transfer time from nanoseconds to better readable form as in the benchmark output
# e.g. x = helper
function helperTimes(time::Float64)
	
	strDim = ["ns", "µs", "ms", "s", "m", "h"] 
	countDim = 1

	while (time >= 1000 && countDim < 4)
        time = time/1000
		countDim = countDim + 1
	end

	while (time > 60 && countDim >= 4 && countDim < 7)
        time = time/60
		countDim = countDim + 1
	end

	#strTime = string(time)
	#len = length(strTime)
	#strTime = string(strTime[1:min(len,5)], " ",strDim[countDim])

	return time, strDim[countDim]
end


#function that writes the benchmark into an excel file at a specific location
function benchmarkToExcel(excelFile::String, sheetNbr::Int, benchmark::Any, location::String, objValue::Float64)
	# sheet			excel sheet
	# benchmark		benchmark data from @benchmark
	# location 		desired location in excel file eg "A2"

	#transfer benchmark data to array
	numberSamples = length(benchmark.times)
	#times in benchmark.times are ordered ascending 
	times = benchmark.times;
	medianTime = times[Int(round(length(times)/2))]
	medTime, dimTime = helperTimes(medianTime)
	memory, dimMemory = helperMemoryEst(benchmark.memory)

	#the zeros are added cause otherwise benchmarks are saved as an Array{Float64,1} and XLSX save this format only as a row vector but we need it as a column vector
	#is there a better workaround? idea is that the zeros get overwritten in every step when this function gets repeated with a shifted location so they are not to distrubing...
	benchmarkvalues = [[memory dimMemory]; [medTime dimTime]; [ "" ""]; [numberSamples ""]; [ ((objValue == 0.0) ? "" : objValue ) ""]]
	XLSX.openxlsx(excelFile, mode="rw") do xf
		
		#in the excel xf we write on the first sheet
		sheet = xf[sheetNbr]
		#save the array to the excel sheet
		sheet[location] = benchmarkvalues

	end
end

end
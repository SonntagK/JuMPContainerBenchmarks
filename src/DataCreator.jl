# JuMP:         for DenseAxisArray
# Random:       for random strings
# JLD2:          to save data to Harddrive
module DataCreator

using JuMP, Random, JLD, Dictionaries, NamedDims

export createAllData

# create array data used to generate all other data
function createBasicData(n::Int64)
    
    # create random data used for all tests
    arrayCoeff = rand(n,n)
    arrayBound = (ones(n)+rand(n))*sqrt(n)/2

    return arrayCoeff, arrayBound
end

# create array of strings to use for all models with string indexing
function createArrayString(n::Int64)
    str_obj = Array{String,1}(undef,n)
    str_con = similar(str_obj)

    #string have a length of 20 and are numbered
    for p in 1:n
		str_obj[p] = string("obj_", randstring(15-length(string(p))), "_", string(p))
		str_con[p] = string("con_", randstring(15-length(string(p))), "_", string(p))
    end

    return str_obj, str_con
end

# denseAxisArray data
function createDenseAxisArrayData(coeff::Array{Float64,2}, bound::Array{Float64,1})

	# random n by n matrix
	denseAxisArrayCoeff = JuMP.Containers.DenseAxisArray(coeff,1:length(coeff[:,1]),1:length(coeff[1,:]))

    # vector used defining contraints
    denseAxisArrayBound = JuMP.Containers.DenseAxisArray(bound,1:length(bound))
    
    return denseAxisArrayCoeff, denseAxisArrayBound
end


# denseAxisArray data
function createDenseAxisArrayDataStr(coeff::Array{Float64,2}, bound::Array{Float64,1}, str_obj::Array{String,1}, str_con::Array{String,1})

	# random n by n matrix
	denseAxisArrayCoeffStr = JuMP.Containers.DenseAxisArray(coeff, str_con, str_obj)

    # vector used defining contraints
    denseAxisArrayBoundStr = JuMP.Containers.DenseAxisArray(bound, str_con)
    
    return denseAxisArrayCoeffStr, denseAxisArrayBoundStr
end

# denseAxisArray data
function createDictData(coeff::Array{Float64,2}, bound::Array{Float64,1})

    DictCoeff = Dict()
    DictBound = Dict()

    for i in 1:length(coeff[:,1])
        for j in 1:length(coeff[1,:])
            DictCoeff[i,j] = coeff[i,j]
        end
        DictBound[i] = bound[i]
    end
    
    return DictCoeff, DictBound
end

# denseAxisArray data
function createDictDataStr(coeff::Array{Float64,2}, bound::Array{Float64,1}, str_obj::Array{String,1}, str_con::Array{String,1})

    DictCoeff = Dict{Tuple{String,String},Float64}()
    DictBound = Dict{String,Float64}()

    for i in 1:length(coeff[:,1])
        for j in 1:length(coeff[1,:])
            DictCoeff[str_con[i],str_obj[j]] = coeff[i,j]
        end
        DictBound[str_con[i]] = bound[i]
    end
    
    return DictCoeff, DictBound
end

function createDictionaryData(coeff::Array{Float64,2}, bound::Array{Float64,1})

    dictCoeff = Dictionary(coeff)
    dictBound = Dictionary(bound)
    
    return dictCoeff, dictBound
end

function createDictionaryData(coeff::Array{Float64,2}, bound::Array{Float64,1})

    dictCoeff = Dictionary(coeff)
    dictBound = Dictionary(bound)
    
    return dictCoeff, dictBound
end

# denseAxisArray data
function createNamedDimsData(coeff::Array{Float64,2}, bound::Array{Float64,1})

    NamedDimsCoeff = NamedDimsArray{(:x1,:x2)}(coeff)
    NamedDimsBound = NamedDimsArray{(:x1,)}(bound)
    
    return NamedDimsCoeff, NamedDimsBound
end

# create all data and save to harddrive for specified problem size n
function createAllData(n::Int)
    arrayCoeff, arrayBound = createBasicData(n)
    str_obj, str_con = createArrayString(n)
    denseAxisArrayCoeff, denseAxisArrayBound = createDenseAxisArrayData(arrayCoeff, arrayBound)
    denseAxisArrayCoeffStr, denseAxisArrayBoundStr = createDenseAxisArrayDataStr(arrayCoeff, arrayBound,str_obj, str_con)
    dictCoeff, dictBound = createDictData(arrayCoeff, arrayBound)
    dictCoeffStr, dictBoundStr = createDictDataStr(arrayCoeff, arrayBound, str_obj, str_con)
    dictionaryCoeff, dictionaryBound = createDictionaryData(arrayCoeff, arrayBound)
    NamedDimsCoeff, NamedDimsBound = createNamedDimsData(arrayCoeff, arrayBound)

    #save data to .jld file
    save("Data/arrayData.jld", "n", n, "arrayCoeff", arrayCoeff, "arrayBound", arrayBound)
    
    save("Data/denseAxisArrayData.jld", "n", n, "arrayCoeff", denseAxisArrayCoeff, "arrayBound", denseAxisArrayBound)
    save("Data/denseAxisArrayDataStr.jld", "n", n, "str_obj", str_obj, "str_con", str_con, "arrayCoeff", denseAxisArrayCoeffStr, "arrayBound", denseAxisArrayBoundStr)
    
    save("Data/dictData.jld", "n", n, "arrayCoeff", dictCoeff, "arrayBound", dictBound)
    #save("Data/dictDataStr.jld", "n", n, "str_obj", str_obj, "str_con", str_con, "arrayCoeff", dictCoeffStr, "arrayBound", dictBoundStr)

    save("Data/dictionaryData.jld", "n", n, "arrayCoeff", dictionaryCoeff, "arrayBound", dictionaryBound)

    save("Data/namedDimsData.jld", "n", n, "arrayCoeff", NamedDimsCoeff, "arrayBound", NamedDimsBound)

    println("Data Saved succesfully")
end

end
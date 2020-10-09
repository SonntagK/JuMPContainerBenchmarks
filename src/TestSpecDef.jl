module TestSpecDef

export TestSpec, DataType, A, AL, ALB, DAA, DAAL, DAALS, DAALB, DAAS20, D, DS, DD, ND

@enum DataType A AL ALB DAA DAAL DAALS DAALB DAAS20 D DS DD ND

struct  TestSpec
    dataTypeID::DataType
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
end

end
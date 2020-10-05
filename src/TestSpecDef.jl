module TestSpecDef

export TestSpec, DataType, A, AL, ALB, DAA, DAAL, DAALS, DAALB, DAAS20, D, DS, DD, ND, Optimizers, CPLEX_opt, Gurobi_opt, Mosek_opt, Xpress_opt

@enum DataType A AL ALB DAA DAAL DAALS DAALB DAAS20 D DS DD ND
@enum Optimizers CPLEX_opt Gurobi_opt Mosek_opt Xpress_opt

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
    writeProfileLog::Bool
    optimizer::Optimizers
end

end
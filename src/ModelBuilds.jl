module ModelBuilds

using TestSpecDef, JuMP, CPLEX, Dictionaries, NamedDims

export arrayModel, arrayModelLongName, arrayModelLongBasename, denseAxisArrayModel, denseAxisArrayModelLongBasename, denseAxisArrayModelLongName, denseAxisArrayModelLongNameShortBasename, denseAxisArrayModelStr20, dictModel, dictModelStr, dictionaryModel, namedDimsModel

#core function that includes model build and optimization for various problem specifications
function arrayModel(coeff::Array{Float64,2}, bound::Array{Float64,1}, n::Int64, directMode::Bool, optimization::Bool, optimizer::Optimizers)
	#DataType A

	#coeff 				matrix: for defintion of the linear constraints of the form coeff*x .<= bound
	#bound 				array: for definition of constraints (see above)
	#n 					integer: showing problem size
	#directMode 		bool: info for model build
	#optimization		bool: shall the JuMP model be optimized



	if directMode == false
		m = Model();
		if optimizer == CPLEX_opt
			set_optimizer(m, CPLEX.Optimizer)
		elseif optimizer == Gurobi_opt
			set_optimizer(m, Gurobi.Optimizer)	
		elseif optimizer == Mosek_opt
			set_optimizer(m, Mosek.Optimizer)
		elseif optimizer == Xpress_opt
			set_optimizer(m, Xpress.Optimizer)
		end
	else
		if optimizer == CPLEX_opt
			m = direct_model(CPLEX.Optimizer());
		elseif optimizer == Gurobi_opt
			m = direct_model(Gurobi.Optimizer());
		elseif optimizer == Mosek_opt
			m = direct_model(Mosek.Optimizer());
		elseif optimizer == Xpress_opt
			m = direct_model(Xpress.Optimizer());
		end
	end

	@variable(m,0<= x[1:n]<=1)
	@constraint(m, con[i = 1:n], sum(coeff[i,j].*x[j] for j = 1:n) <= bound[i] )
	
	@objective(m, Max, sum(x))
		
	if optimization == true
		JuMP.optimize!(m)
	end
	
	return(m)

end

function arrayModelLongName(coeff::Array{Float64,2}, bound::Array{Float64,1}, n::Int64, directMode::Bool, optimization::Bool)
	#DataType AL

	#coeff 				matrix: for defintion of the linear constraints of the form coeff*x .<= bound
	#bound 				array: for definition of constraints (see above)
	#n 					integer: showing problem size
	#directMode 		bool: info for model build
	#optimization		bool: shall the JuMP model be optimized


	if directMode == false
		m = Model();
		set_optimizer(m, CPLEX.Optimizer)
	else
		m = direct_model(CPLEX.Optimizer());
	end

	@variable(m, 0<= verylooooooooongname[1:n]<=1,base_name = "x")
	@constraint(m, con[i = 1:n], sum(coeff[i,:].*verylooooooooongname) <= bound[i] )
	

	@objective(m, Max, sum(verylooooooooongname))
		
	if optimization == true
		JuMP.optimize!(m)
	end
	
	return(m)

end

function arrayModelLongBasename(coeff::Array{Float64,2}, bound::Array{Float64,1}, n::Int64, directMode::Bool, optimization::Bool)
	#DataType ALB

	#coeff 				matrix: for defintion of the linear constraints of the form coeff*x .<= bound
	#bound 				array: for definition of constraints (see above)
	#n 					integer: showing problem size
	#directMode 		bool: info for model build
	#optimization		bool: shall the JuMP model be optimized

	if directMode == false
		m = Model();
		et_optimizer(m, CPLEX.Optimizer)	
	else
		m = direct_model(CPLEX.Optimizer());	
	end

	@variable(m, 0<= x[1:n]<=1,base_name = "VERYLOOOOOOOOONGNAME")
	@constraint(m, con[i = 1:n], sum(coeff[i,:].*x) <= bound[i] )
	

	obj = @objective(m, Max, sum(x))
		
	if optimization == true
		JuMP.optimize!(m)
	end
	
	return(m)

end

function denseAxisArrayModel(coeff::JuMP.Containers.DenseAxisArray{Float64,2,Tuple{UnitRange{Int64},UnitRange{Int64}},Tuple{Dict{Int64,Int64},Dict{Int64,Int64}}},
	bound::JuMP.Containers.DenseAxisArray{Float64,1,Tuple{UnitRange{Int64}},Tuple{Dict{Int64,Int64}}}, n::Int64, directMode::Bool, optimization::Bool)
	#DataType DAA

	#coeff 				matrix: for defintion of the linear constraints of the form coeff*x .<= bound
	#bound 				array: for definition of constraints (see above)
	#n 					integer: showing problem size
	#directMode 		bool: info for model build
	#optimization		bool: shall the JuMP model be optimized

	if directMode == false
		m = Model();
		set_optimizer(m, CPLEX.Optimizer)
	else
		m = direct_model(CPLEX.Optimizer());	
	end

	@variable(m,0<= x[1:n]<=1, container = DenseAxisArray)
	@constraint(m, con[i = 1:n], sum(coeff[i,j]*x[j] for j in 1:n) <= bound[i], container = DenseAxisArray)
	

	@objective(m, Max, sum(x[j] for j in 1:n))

	if optimization == true
		JuMP.optimize!(m)
	end

	return(m)
end

function denseAxisArrayModelLongName(coeff::JuMP.Containers.DenseAxisArray{Float64,2,Tuple{UnitRange{Int64},UnitRange{Int64}},Tuple{Dict{Int64,Int64},Dict{Int64,Int64}}},
	bound::JuMP.Containers.DenseAxisArray{Float64,1,Tuple{UnitRange{Int64}},Tuple{Dict{Int64,Int64}}}, n::Int64, directMode::Bool, optimization::Bool)
	#DataType DAAL

	#coeff 				matrix: for defintion of the linear constraints of the form coeff*x .<= bound
	#bound 				array: for definition of constraints (see above)
	#n 					integer: showing problem size
	#directMode 		bool: info for model build
	#optimization		bool: shall the JuMP model be optimized

	if directMode == false
		m = Model();
		set_optimizer(m, CPLEX.Optimizer)
	else
		m = direct_model(CPLEX.Optimizer());
	end

	@variable(m,0<= verylooooooongname_x[1:n]<=1, container = DenseAxisArray)

	@constraint(m, verylooooongname_con[i=1:n], sum(coeff[i,j]*verylooooooongname_x[j] for j in 1:n) <= bound[i], container = DenseAxisArray)


	@objective(m, Max, sum(verylooooooongname_x[j] for j in 1:n))

	if optimization == true
		JuMP.optimize!(m)
	end

	return(m)
end

function denseAxisArrayModelLongNameShortBasename(coeff::JuMP.Containers.DenseAxisArray{Float64,2,Tuple{UnitRange{Int64},UnitRange{Int64}},Tuple{Dict{Int64,Int64},Dict{Int64,Int64}}},
	bound::JuMP.Containers.DenseAxisArray{Float64,1,Tuple{UnitRange{Int64}},Tuple{Dict{Int64,Int64}}}, n::Int64, directMode::Bool, optimization::Bool)
	#DataType DAALS
	
	#coeff 				matrix: for defintion of the linear constraints of the form coeff*x .<= bound
	#bound 				array: for definition of constraints (see above)
	#n 					integer: showing problem size
	#directMode 		bool: info for model build
	#optimization		bool: shall the JuMP model be optimized

	if directMode == false
		m = Model();
		set_optimizer(m, CPLEX.Optimizer)		
	else
		m = direct_model(CPLEX.Optimizer());
	end

	@variable(m,0<= verylooooooongname_x[1:n]<=1, container = DenseAxisArray, base_name = "x")

	@constraint(m, verylooooongname_con[i=1:n], sum(coeff[i,j]*verylooooooongname_x[j] for j in 1:n) <= bound[i], container = DenseAxisArray)


	@objective(m, Max, sum(verylooooooongname_x[j] for j in 1:n))

	if optimization == true
		JuMP.optimize!(m)
	end

	return(m)
end

function denseAxisArrayModelLongBasename(coeff::JuMP.Containers.DenseAxisArray{Float64,2,Tuple{UnitRange{Int64},UnitRange{Int64}},Tuple{Dict{Int64,Int64},Dict{Int64,Int64}}},
	bound::JuMP.Containers.DenseAxisArray{Float64,1,Tuple{UnitRange{Int64}},Tuple{Dict{Int64,Int64}}}, n::Int64, directMode::Bool, optimization::Bool)
	#DAALB
	
	#coeff 				matrix: for defintion of the linear constraints of the form coeff*x .<= bound
	#bound 				array: for definition of constraints (see above)
	#n 					integer: showing problem size
	#directMode 		bool: info for model build
	#optimization		bool: shall the JuMP model be optimized

	if directMode == false
		m = Model();
		set_optimizer(m, CPLEX.Optimizer)	
	else
		m = direct_model(CPLEX.Optimizer());
	end

	@variable(m,0<= x[1:n]<=1, container = DenseAxisArray, base_name = "VERYLOOOOOOOOONGNAME")

	@constraint(m, con[i=1:n], sum(coeff[i,j]*x[j] for j in 1:n) <= bound[i], container = DenseAxisArray)


	@objective(m, Max, sum(x[j] for j in 1:n))

	if optimization == true
		JuMP.optimize!(m)
	end

	return(m)
end

function denseAxisArrayModelStr20(coeff::JuMP.Containers.DenseAxisArray{Float64,2,Tuple{Array{String,1},Array{String,1}},Tuple{Dict{String,Int64},Dict{String,Int64}}},
	bound::JuMP.Containers.DenseAxisArray{Float64,1,Tuple{Array{String,1}},Tuple{Dict{String,Int64}}},
	str_obj::Array{String,1}, str_con::Array{String,1}, directMode::Bool, optimization::Bool)
	#DataType DAAS20

	#coeff 				matrix: for defintion of the linear constraints of the form coeff*x .<= bound
	#bound 				array: for definition of constraints (see above)
	#n 					integer: showing problem size
	#directMode 		bool: info for model build
	#optimization		bool: shall the JuMP model be optimized

	if directMode == false
		m = Model();
		set_optimizer(m, CPLEX.Optimizer)

	else
		m = direct_model(CPLEX.Optimizer());
	end

	@variable(m,0<= x[str_obj]<=1)

	@constraint(m, con[name_con in str_con], sum(coeff[name_con,name_obj]*x[name_obj] for name_obj in str_obj) <= bound[name_con])


	@objective(m, Max, sum(x[name_obj] for name_obj in str_obj))

	if optimization == true
		JuMP.optimize!(m)
	end

	return(m)
end

function dictModel(coeff::Dict{Any,Any}, bound::Dict{Any,Any}, n::Int64, directMode::Bool, optimization::Bool)
	#DataType D

	#coeff 				matrix: for defintion of the linear constraints of the form coeff*x .<= bound
	#bound 				array: for definition of constraints (see above)
	#n 					integer: showing problem size
	#directMode 		bool: info for model build
	#optimization		bool: shall the JuMP model be optimized

	if directMode == false
		m = Model();
		set_optimizer(m, CPLEX.Optimizer)
	else
		m = direct_model(CPLEX.Optimizer());	
	end
	
	x = Dict()
	for j = 1:n
		x[j] = @variable(m, lower_bound = 0, upper_bound =1)
	end

	con = Dict()
	for i = 1:n
		con[i] = @constraint(m, sum(coeff[i,j]*x[j] for j in 1:n) <= bound[i])
	end


	@objective(m, Max, sum(x[j] for j in 1:n))

	if optimization == true
		JuMP.optimize!(m)
	end

	return(m)
end

function dictModelStr(coeff::Dict{Any,Any}, bound::Dict{Any,Any}, str_obj::Array{String,1}, str_con::Array{String,1}, directMode::Bool, optimization::Bool)
	#DataType DS
	
	#coeff 				matrix: for defintion of the linear constraints of the form coeff*x .<= bound
	#bound 				array: for definition of constraints (see above)
	#n 					integer: showing problem size
	#directMode 		bool: info for model build
	#optimization		bool: shall the JuMP model be optimized

	if directMode == false
		m = Model();
		set_optimizer(m, CPLEX.Optimizer)	
	else
		m = direct_model(CPLEX.Optimizer());
	end
	
	x = Dict()
	for name_obj in str_obj
		x[name_obj] = @variable(m, lower_bound = 0, upper_bound = 1)
	end

	con = Dict()
	for name_con in str_con
		con[name_con] = @constraint(m, sum(coeff[name_con, name_obj]*x[name_obj] for name_obj in str_obj) <= bound[name_con])
	end

	@objective(m, Max, sum(x[name_obj] for name_obj in str_obj))

	if optimization == true
		JuMP.optimize!(m)
	end

	return(m)
end

function dictionaryModel(coeff::Dictionary{CartesianIndex{2},Float64}, bound::Dictionary{Int64,Float64}, n::Int64, directMode::Bool, optimization::Bool)
	#DataType DD
	
	#coeff 				matrix: for defintion of the linear constraints of the form coeff*x .<= bound
	#bound 				array: for definition of constraints (see above)
	#n 					integer: showing problem size
	#directMode 		bool: info for model build
	#optimization		bool: shall the JuMP model be optimized

	if directMode == false
		m = Model();
		set_optimizer(m, CPLEX.Optimizer)	
	else
		m = direct_model(CPLEX.Optimizer());	
	end
	
	x = Dictionary(1:n,@variable(m, 0 <= x[1:n] <= 1))
	con = Dictionary(1:n, @constraint(m, con[i = 1:n], sum(coeff[CartesianIndex(i ,j)]*x[j] for j in 1:n) <= bound[i]))


	@objective(m, Max, sum(x[j] for j in 1:n))

	if optimization == true
		JuMP.optimize!(m)
	end

	return(m)
end

function namedDimsModel(coeff::NamedDimsArray{(:x1, :x2),Float64,2,Array{Float64,2}}, bound::NamedDimsArray{(:x1,),Float64,1,Array{Float64,1}}, n::Int64, directMode::Bool, optimization::Bool, optimizer::Optimizers)
	#DataType ND
	
	#coeff 				matrix: for defintion of the linear constraints of the form coeff*x .<= bound
	#bound 				array: for definition of constraints (see above)
	#n 					integer: showing problem size
	#directMode 		bool: info for model build
	#optimization		bool: shall the JuMP model be optimized
	
	if directMode == false
		m = Model();
		set_optimizer(m, CPLEX.Optimizer)	
	else
		m = direct_model(CPLEX.Optimizer());	
	end
	
	x = NamedDimsArray{(:x2,)}(@variable(m, 0 <= x[1:n] <= 1))

	con = NamedDimsArray{(:x1,)}(@constraint(m, con[i = 1:n], sum(coeff[x1 = i ,x2 = j]*x[x2 = j] for j in 1:n) <= bound[i] ))


	@objective(m, Max, sum(x[j] for j in 1:n))

	if optimization == true
		JuMP.optimize!(m)
	end

	return(m)
end

end
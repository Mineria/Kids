class OperationsController < ApplicationController

  def index
    #@operations = Operation.all
  end

  def new
    ops = ["+", "-", "/", "*"]
    
    @operation = Operation.new
    @operation.operand1 = rand(1..99)
    @operation.operand2 = rand(1..99)
    @operation.operator = ops[rand(0..3)]
    @operation.time_init = Time.new
    @operation.save
  end

  # POST /operations
  def create
    @operation = Operation.find(params[:id])

    if @operation and @operation.validate_response? params[:response].to_i
        @operation.register_response_time
        render "response"
    else
      # Redirect to same view
      render :new
    end

    # @pelicula = Pelicula.new(pelicula_params)
  end

end

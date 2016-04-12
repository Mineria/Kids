class OperationsController < ApplicationController

  def index
    #@operations = Operation.all
  end

  def new
    @operation = Operation.new
    @operation.operand1 = 2
    @operation.operand2 = 5
    @operation.operator = "+"
    @operation.save
  end

  # POST /operations
  def create
    @operation = Operation.find(params[:id])

    if @operation
      if @operation.validate_response
        @operation.register_response_time
      end
    else
      # Redirect to same view
      render :new
    end

    # @pelicula = Pelicula.new(pelicula_params)
  end

end

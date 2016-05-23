require 'net/http'

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

  def get_operator_number
    operator = @operation.operator
    if operator == "+"
      1
    elsif operator == "-"
      2
    elsif operator == "/"
      3
    elsif operator == "*"
      4
    end
  end

  def resonse_time_number response_time
    puts response_time
    return response_time / 5
    if response_time < 20.0
        return 0
    else
        return 1
    end
  end

  def estimate

    op1 = @operation.operand1
    op2 = @operation.operand2
    time = @operation.get_responsive_time.to_f
    operator = get_operator_number

    url = URI.parse("http://127.0.0.1:5000/predict/#{op1}/#{operator}/#{op2}/#{time}")

    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }

    estimatation_number = res.body.to_i
    response_time_number = resonse_time_number(time).to_i

    puts estimatation_number
    puts response_time_number

    if response_time_number < estimatation_number
      true
    else
      false
    end
  end

  # POST /operations
  def create
    @operation = Operation.find(params[:id])

    if @operation and @operation.validate_response? params[:response].to_i

        @operation.register_response_time
        @good_response_time = estimate

        puts @good_response_time
        render "response"
    else
      # Redirect to same view
      render :new
    end

    # @pelicula = Pelicula.new(pelicula_params)
  end

end

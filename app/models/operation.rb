#class Operation < ActiveRecord::Base
class Operation

  include Mongoid::Document

  field :name, type: String
  field :time_init, type: Time, default: Time.new
  field :time_end, type: Time

  field :operand1, type: Integer
  field :operand2, type: Integer
  field :operator, type: String

  def validate_response response
    if self.operator == "+"
      result = @operand1 + @operand2
      response == result
    end
  end

  def register_response_time
    self.time_end = Time.new
    save
  end

  # Register time elapsed to
  def get_responsive_time
    current_time = Time.new
    (current_time - self.time_init)
  end

end

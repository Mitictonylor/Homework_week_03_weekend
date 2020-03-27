require_relative('../db/sql_runner.rb')

class Customer

attr_accessor :name, :founds
attr_reader :id

  def initialize(customer)
      @id = customer['id'].to_i if customer['id']
      @name = customer['name']
      @founds = customer['founds']
  end

def save()
  sql = "INSERT INTO customers (name, founds) VALUES ($1, $2) RETURNING id;"
  values = [@name, @founds]
  @id = SqlRunner.run(sql, values)[0]['id'].to_i
end






end

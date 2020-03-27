require_relative('../db/sql_runner.rb')

class Screening
  attr_accessor :show_time, :ticket_available
  attr_reader :id


  def initialize(screening)
    @id = screening['id'].to_i if screening['id']
    @show_time = screening['show_time']
    @ticket_available = screening['ticket_available'].to_i
  end

  def save()
    sql = "INSERT INTO screenings (show_time, ticket_available) VALUES ($1, $2) RETURNING id;"
    values = [@show_time, @ticket_available]
    @id = SqlRunner.run(sql,values)[0]['id'].to_i
  end








end

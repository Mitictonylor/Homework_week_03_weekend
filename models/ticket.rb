require_relative('../db/sql_runner.rb')

class Ticket

  attr_accessor :customer_id, :film_id, :screening_id
  attr_reader :id

  def initialize(ticket)
    @id = ticket['id'].to_i if ticket['id']
    @customer_id = ticket['customer_id'].to_i
    @film_id = ticket['film_id'].to_i
    @screening_id = ticket['screening_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id, screening_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@customer_id, @film_id, @screening_id]
    @id = SqlRunner.run(sql,values)[0]['id'].to_i
  end









end

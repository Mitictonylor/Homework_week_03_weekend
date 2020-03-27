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

  def self.all()
    sql = "SELECT * FROM screenings"
    all = SqlRunner.run(sql)
    return all.map{|screening| Screening.new(screening)}
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    return SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE customers SET (show_time,ticket_available) = ($1, $2) WHERE id = $3"
    values = [@show_time, @ticket_available, @id]
    return SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    return SqlRunner.run(sql,values)
  end

def ticket_sold()
  @ticket_available -= 1
  update()
end

def ticket_available?()
  return true if @ticket_available > 0
end
end

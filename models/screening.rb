require_relative('../db/sql_runner.rb')
require_relative('./customer.rb')

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
    sql = "UPDATE screenings SET (show_time,ticket_available) = ($1, $2) WHERE id = $3"
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

  def count_customer_par_show
    sql = "SELECT tickets.screening_id FROM tickets
          INNER JOIN screenings ON screenings.id = tickets.screening_id
          WHERE screenings.id = $1"
    values=[@id]
    result = SqlRunner.run(sql,values)
    return result.map{|a| a.length}.size()
  end

  def self.popular(film_id)
    sql = "SELECT tickets.screening_id FROM tickets
          INNER JOIN screenings ON screenings.id = tickets.screening_id
          INNER JOIN films ON films.id = tickets.film_id
          WHERE tickets.film_id = $1 GROUP BY tickets.screening_id
          ORDER BY COUNT(tickets.screening_id) DESC
          LIMIT 1"
    values=[film_id]
    all = SqlRunner.run(sql, values)
    result = all.map{|screening| Ticket.new(screening)}
    #needs to count the same screeining_id in ticket
#     grouping_by_screening_id = result.group_by{|k,v| v}
# return grouping_by_screening_id
return result
  end

end

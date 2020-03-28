require_relative('../db/sql_runner.rb')
require_relative('./screening.rb')
require_relative('./ticket.rb')
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

  def self.all()
    sql = "SELECT * FROM customers"
    all = SqlRunner.run(sql)
    return all.map{|customer| Customer.new(customer)}
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    return SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE customers SET (name, founds) = ($1, $2) WHERE id = $3"
    values = [@name, @founds, @id]
    return SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    return SqlRunner.run(sql,values)
  end

  def have_ticket_for_which_films()
    sql = "SELECT films.*FROM films
          INNER JOIN tickets
          ON tickets.film_id = films.id
          WHERE tickets.customer_id = $1;"
    values = [@id]
    films = SqlRunner.run(sql,values)
    return films.map{|film| Film.new(film)}
  end
# #not working on pry, working on psql????
#   def how_many_films2()
#     sql = "SELECT count(*) FROM films
#     INNER JOIN tickets
#     ON tickets.film_id = films.id
#     WHERE tickets.customer_id = $1"
#     values = [$1]
#     results SqlRunner.run(sql,values)[0]
#   end
  def how_many_films()
    return have_ticket_for_which_films().size()
  end

  def find_price(film_id, screening_id)
    sql = "SELECT films.price FROM films
          INNER JOIN tickets
          ON tickets.film_id = films.id
          WHERE tickets.customer_id = $1 AND tickets.film_id = $2 AND tickets.screening_id = $3"
    values = [@id, film_id, screening_id]
    return SqlRunner.run(sql,values)[0]['price'].to_f
  end

    def buy_ticket(film, screening)
      price = film.price
      if @founds >= price && screening.ticket_available?()
        @founds -= price
        update()
        screening.ticket_sold()
        new_ticket = Ticket.new({'customer_id' => @id,
                              'film_id' => film.id,
                              'screening_id' => screening.id
                              })
        new_ticket.save()
        return p "Ticket id#{new_ticket.id} has been submitted"
      elsif @founds < price
        p "Not enough money"
      else
        p "Not enough ticket for this film"
      end

    end
end

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

end

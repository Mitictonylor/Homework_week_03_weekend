require_relative('../db/sql_runner.rb')

class Film

  attr_accessor :title, :price
  attr_reader :id


  def initialize(film)
    @id = film['id'].to_i if film['id']
    @title = film['title']
    @price = film['price'].to_f
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1,$2) RETURNING ID"
    values = [@title, @price]
    @id = SqlRunner.run(sql,values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    all = SqlRunner.run(sql)
    return all.map{|film| Film.new(film)}
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    return SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE customers SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    return SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    return SqlRunner.run(sql,values)
  end

  def customers_per_movie()
    sql = "SELECT customers.* FROM customers
           INNER JOIN tickets
           ON tickets.customer_id = customers.id
           WHERE tickets.film_id = $1;"
    values = [@id]
    customers = SqlRunner.run(sql,values)
    return customers.map{|customer| Customer.new(customer)}
  end







end

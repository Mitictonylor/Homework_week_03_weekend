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










end

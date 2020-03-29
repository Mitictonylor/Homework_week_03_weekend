require("pry-byebug")
require_relative("./models/customer.rb")
require_relative("./models/film.rb")
require_relative("./models/screening.rb")
require_relative("./models/ticket.rb")

Ticket.delete_all()
Customer.delete_all()
Screening.delete_all()
Film.delete_all()

customer1 = Customer.new({'name' => 'Antonio',
                          'founds' => 40.0
                        });
customer1.save();

customer2 = Customer.new({'name' => 'Alex',
                          'founds' => 80.25
                        });
customer2.save();

customer3 = Customer.new({'name' => 'Ivan',
                          'founds' => 100.0
                        });
customer3.save();

customer4 = Customer.new({'name' => 'Keira',
                          'founds' => 68.44
                        });
customer4.save();


film1 = Film.new({'title' => "Avengers",
                  'price' => 8.00
                })
film1.save()

film2 = Film.new({'title' => "Hulk",
                  'price' => 7.00
                  })
film2.save()

screen1 = Screening.new({'show_time' => '18:30',
                          'ticket_available' => 100
                        })
screen1.save()

screen2 = Screening.new({'show_time' => '15:30',
                          'ticket_available' => 100
                        })
screen2.save()

screen3 = Screening.new({'show_time' => '16:00',
                        'ticket_available' => 100
                        })
screen3.save()

customer1.buy_ticket(film1,screen1)
customer2.buy_ticket(film1,screen1)
customer3.buy_ticket(film1,screen1)
customer4.buy_ticket(film2,screen2)
customer4.buy_ticket(film1,screen3)
customer1.buy_ticket(film1,screen3)


#antonio, bought a ticket for avengers show at 18:30
# ticket1 = Ticket.new({'customer_id' => customer1.id,
#                       'film_id' => film1.id,
#                       'screening_id' => screen1.id
#                       })
# ticket1.save()
#
#
# ticket2 = Ticket.new({'customer_id' => customer2.id,
#                       'film_id' => film1.id,
#                       'screening_id' => screen1.id
#                       })
# ticket2.save()
#
# ticket3 = Ticket.new({'customer_id' => customer3.id,
#                       'film_id' => film1.id,
#                       'screening_id' => screen1.id
#                       })
# ticket3.save()
#
# ticket4 = Ticket.new({'customer_id' => customer4.id,
#                       'film_id' => film2.id,
#                       'screening_id' => screen2.id
#                       })
# ticket4.save()
#
# ticket5 = Ticket.new({'customer_id' => customer1.id,
#                       'film_id' => film2.id,
#                       'screening_id' => screen2.id
#                       })
# ticket5.save()
#
# ticket6 = Ticket.new({'customer_id' => customer1.id,
#                       'film_id' => film1.id,
#                       'screening_id' => screen3.id
#                       })
# ticket6.save()

binding.pry
nil

require("pry-byebug")
require_relative("./models/customer.rb")
require_relative("./models/film.rb")
require_relative("./models/screening.rb")
require_relative("./models/ticket.rb")


customer1 = Customer.new({'name' => 'Antonio',
                          'founds' => 40.0
                        });
customer1.save();

customer2 = Customer.new({'name' => 'Alex',
                          'founds' => 80.25
                        });
customer2.save();

customer3 = Customer.new({'name' => 'Francesco',
                          'founds' => 100.0
                        });
customer3.save();

customer4 = Customer.new({'name' => 'Keira',
                          'founds' => 68.44
                        });
customer4.save();






binding.pry
nil

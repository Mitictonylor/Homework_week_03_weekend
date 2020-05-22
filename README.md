Codeclan week 3 weekend Homework
Create a Cinema App to track movies and showtimes

Ruby, PostgreSQL, Sinatra



# Setup

- make sure you have Ruby and PostgreSQL installed on your machine

- Clone/save the repository


**In The Terminal**:

- Install Sinatra
gem install sinatra
- Create the  database
createdb cinema
- Access and create the database tables
psql -d cinema -f db/cinema.sql
- Populate the tables
ruby console.rb
- Run the app
ruby controller.rb
- Go to http://localhost:4567 in your browser

# Cinema

---

# Brief

Create a system that handles bookings for our newly built cinema! It’s enough if you can call your methods in pry, don’t worry about an interface.

Your app should have:

Customers:
- name
- funds

Films:
- title
- price

Tickets:
- customer_id
- film_id

Your app should be able to:
- Create customers, films and tickets
- CRUD actions (create, read, update, delete) customers, films and tickets.
- Show which films a customer has booked to see, and see which customers are coming to see one film.

**Basic extensions**

- Buying tickets should decrease the funds of the customer by the price
- Check how many tickets were bought by a customer
- Check how many customers are going to watch a certain film

**Advanced extensions**

- Create a screenings table that lets us know what time films are showing
- Write a method that finds out what is the most popular time (most tickets sold) for a given film
- Limit the available tickets for screenings.
Add any other extensions you think would be great to have at a cinema!

require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


require_relative('../models/screening')



class TestScreening < Minitest::Test
  def setup()
    @screen1 = Screening.new({'show_time' => '18:30',
                              'ticket_available' => 100
                            })
  end

  def test_reduce_number_of_available_seat()
    @screen1.ticket_sold()
    assert_equal(99, @screen1.ticket_available())
  end

  def test_ticket_are_still_available()
    assert_equal(true, @screen1.ticket_available?())
  end
end

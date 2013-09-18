require 'minitest'
require 'minitest/autorun'
require './lib/phone_number'

class PhoneNumberTest < MiniTest::Unit::TestCase

  def test_it_can_change_phone_numbers
    data = {:phone_number => '2024556677'}
    attendee = Attendee.new(data)
    assert_equal data [:phone_number], attendee.phone_number
    attendee.phone_number = "1234567890"
    assert_equal "1234567890", attendee.phone_number
  end

  def test_it_cleans_up_phone_numbers_with_periods_and_hyphens
    attendee = Attendee.new(:phone_number => "202.444-9382")
    assert_equal "2024449382", attendee.phone_number
  end

  def test_it_removes_leading_one_from_an_eleven_digit_phone_number
    attendee = Attendee.new(:phone_number => "12024449382")
    assert_equal "2024449382", attendee.phone_number
  end

  def test_it_throws_away_phone_numbers_that_are_too_long
    attendee = Attendee.new(:phone_number => "23334445555")
    assert_equal "0000000000", attendee.phone_number
  end

  def test_it_throws_away_phone_numbers_that_are_too_short
    attendee = Attendee.new(:phone_number => "222333444")
    assert_equal "0000000000", attendee.phone_number
  end

end

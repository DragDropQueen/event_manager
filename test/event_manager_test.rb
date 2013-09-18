require 'minitest'
require 'minitest/autorun'
require './lib/event_manager'

class EventManagerTest < MiniTest::Unit::TestCase

  def test_it_exists
    em = EventManager.new
    assert_kind_of EventManager, em
  end
end


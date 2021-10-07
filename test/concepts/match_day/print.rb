require 'minitest/autorun'
require 'concepts/match_day/operations/print'

class MatchDayPrintTest < Minitest::Test
  def test_print
    match_day = [[{:team=>"San Jose Earthquakes", :points=>1}, {:team=>"Santa Cruz Slugs", :points=>1}], [{:team=>"Capitola Seahorses", :points=>3}, {:team=>"Aptos FC", :points=>0}], [{:team=>"Felton Lumberjacks", :points=>3}, {:team=>"Monterey United", :points=>0}]]
    assert_output(/Capitola Seahorses, 3pts/) { MatchDay::Print.perform(match_day: match_day) }
    assert_output(/Felton Lumberjacks, 3pts/) { MatchDay::Print.perform(match_day: match_day) }
    assert_output(/San Jose Earthquakes, 1pt/) { MatchDay::Print.perform(match_day: match_day) }
  end
end

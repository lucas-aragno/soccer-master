require 'minitest/autorun'
require 'concepts/match_day/operations/accumulate_days_and_results.rb'

class MatchDayAccumulateDaysAndResultsTest < Minitest::Test
  def test_accumulate_day_without_previous_day_results
    match_day_results = [[{:team=>"San Jose Earthquakes", :points=>1}, {:team=>"Santa Cruz Slugs", :points=>1}], [{:team=>"Capitola Seahorses", :points=>3}, {:team=>"Aptos FC", :points=>0}], [{:team=>"Felton Lumberjacks", :points=>3}, {:team=>"Monterey United", :points=>0}]]

    match_day_results_and_accumulated_results = MatchDay::AccumulateDaysAndResults.perform(match_day: match_day_results, previous_day_results: {})

    match_day_results.each_with_index do |day_results, index|
      # since is the first day the accumulated results should be the points for the day
      day_results.each do |team_points|
        team = team_points[:team]
        points = team_points[:points]
        assert_equal match_day_results_and_accumulated_results[:accumulated_results][team], points
      end

      # also since it's the first day the match_day should remain unchanged
      assert_equal match_day_results_and_accumulated_results[:match_day][index], day_results
    end
  end


  def test_accumulate_day_with_previous_days_results
    # mocked previous days results
    previous_day_results = {"San Jose Earthquakes"=>1, "Santa Cruz Slugs"=>1, "Capitola Seahorses"=>3, "Aptos FC"=>0, "Felton Lumberjacks"=>3, "Monterey United"=>0}
    # mocked current match day
    match_day_results = [[{:team=>"Aptos FC", :points=>3}, {:team=>"Monterey United", :points=>0}], [{:team=>"Capitola Seahorses", :points=>1}, {:team=>"San Jose Earthquakes", :points=>1}], [{:team=>"Santa Cruz Slugs", :points=>1}, {:team=>"Felton Lumberjacks", :points=>1}]]

    mocked_computed_results = {
      "Aptos FC": 3,
      "Monterey United": 0,
      "Felton Lumberjacks": 4,
      "San Jose Earthquakes": 2,
      "Santa Cruz Slugs": 2,
      "Capitola Seahorses": 4,
    }

    match_day_results_and_accumulated_results = MatchDay::AccumulateDaysAndResults.perform(match_day: match_day_results, previous_day_results: previous_day_results)

    match_day_results_and_accumulated_results[:match_day] do |day_results, index|
      day_results.each do |team_points|
        team = team_points[:team]
        points = team_points[:points]
        assert_equal mocked_computed_results[team], points
      end

      match_day_results_and_accumulated_results[:accumulated_results].each do |team, points|
        assert_equal mocked_computed_results[team], points
      end
    end
  end
end

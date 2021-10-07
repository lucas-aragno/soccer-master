require 'minitest/autorun'
require 'concepts/match/model'
require 'concepts/match_day/model'
require 'concepts/match_day/operations/process_results'
require 'concepts/match/constants'

class MatchDayProcessTest < Minitest::Test
  def test_process_results
    match_day = MatchDay::Model.new
    [
      ['a', 'b'],
      ['c', 'd'],
      ['e', 'f'],
    ].map do |match_arr|
      team_one = TeamScore::Struct.new(match_arr[0], 1)
      team_two = TeamScore::Struct.new(match_arr[1], 0)
      match = Match::Model.new(team_one: team_one, team_two: team_two)
      MatchDay::Add.perform!(match_day: match_day, match: match)
    end

    results =  MatchDay::ProcessResults.perform!(match_day: match_day)

    winners = ['a', 'c', 'e']

    results.flatten.each do |result|
      if winners.include?(result[:team])
        assert_equal result[:points], Match::Constants::WINNING_POINTS
      else
        assert_equal result[:points], Match::Constants::LOSING_POINTS
      end
    end


    #assert_output(/a, 3pts/) { }
    #assert_output(/c, 3pts/) { MatchDay::ProcessResults.perform!(match_day: match_day) }
    #assert_output(/e, 3pts/) { MatchDay::ProcessResults.perform!(match_day: match_day) }
  end
end

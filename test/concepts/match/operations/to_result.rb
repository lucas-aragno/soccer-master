require 'minitest/autorun'
require 'concepts/match/model'
require 'concepts/match/operations/to_result'
require 'concepts/match/constants'

class MatchToResultTest < Minitest::Test
  def test_to_result
    team_one = TeamScore::Struct.new('a', 1)
    team_two = TeamScore::Struct.new('b', 0)
    match = Match::Model.new(team_one: team_one, team_two: team_two)
    result = Match::ToResult.perform!(match: match)
    assert_equal result[0][:team], 'a'
    assert_equal result[0][:points],  Match::Constants::WINNING_POINTS
    assert_equal result[1][:team], 'b'
    assert_equal result[1][:points],  Match::Constants::LOSING_POINTS
  end
end

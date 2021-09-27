require 'minitest/autorun'
require 'concepts/match/model'
require 'concepts/match/operations/compute'
require 'concepts/match/constants'

class MatchComputeTest < Minitest::Test
  def test_team_one_win
    team_one = TeamScore::Struct.new('a', 1)
    team_two = TeamScore::Struct.new('b', 0)
    match = Match::Model.new(team_one: team_one, team_two: team_two)
    Match::Compute.perform!(match: match)
    assert_equal match.points_team_one, Match::Constants::WINNING_POINTS
    assert_equal match.points_team_two, Match::Constants::LOSING_POINTS
  end

  def test_team_two_win
    team_one = TeamScore::Struct.new('a', 1)
    team_two = TeamScore::Struct.new('b', 10)
    match = Match::Model.new(team_one: team_one, team_two: team_two)
    Match::Compute.perform!(match: match)
    assert_equal match.points_team_one, Match::Constants::LOSING_POINTS
    assert_equal match.points_team_two, Match::Constants::WINNING_POINTS
  end

  def test_draw
    team_one = TeamScore::Struct.new('a', 1)
    team_two = TeamScore::Struct.new('b', 1)
    match = Match::Model.new(team_one: team_one, team_two: team_two)
    Match::Compute.perform!(match: match)
    assert_equal match.points_team_one, Match::Constants::DRAW_POINTS
    assert_equal match.points_team_two, Match::Constants::DRAW_POINTS
  end
end

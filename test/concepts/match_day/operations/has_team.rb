require 'minitest/autorun'
require 'concepts/match/model'
require 'concepts/match_day/model'
require 'concepts/match_day/operations/has_team'
require 'concepts/match_day/operations/add'

class MatchDayHasTeamTest < Minitest::Test
  def test_has_team_with_team
    team_one = TeamScore::Struct.new('a', 1)
    team_two = TeamScore::Struct.new('b', 0)
    match = Match::Model.new(team_one: team_one, team_two: team_two)
    match_day = MatchDay::Model.new
    MatchDay::Add.perform!(match_day: match_day, match: match)
    assert MatchDay::HasTeam.perform(match_day: match_day, team: 'a')
  end

  def test_has_team_without_team
    team_one = TeamScore::Struct.new('a', 1)
    team_two = TeamScore::Struct.new('b', 0)
    match = Match::Model.new(team_one: team_one, team_two: team_two)
    match_day = MatchDay::Model.new
    MatchDay::Add.perform!(match_day: match_day, match: match)
    assert !MatchDay::HasTeam.perform(match_day: match_day, team: 'd')
  end
end

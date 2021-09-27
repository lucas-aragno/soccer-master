require 'minitest/autorun'
require 'concepts/match/model'
require 'concepts/match_day/model'
require 'concepts/match_day/operations/print_result'

class MatchDayPrintTest < Minitest::Test
  def test_print
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

    assert_output(/a, 3pts/) { MatchDay::PrintResult.perform!(match_day: match_day) }
    assert_output(/c, 3pts/) { MatchDay::PrintResult.perform!(match_day: match_day) }
    assert_output(/e, 3pts/) { MatchDay::PrintResult.perform!(match_day: match_day) }
  end
end

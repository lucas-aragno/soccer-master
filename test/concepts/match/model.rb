require 'minitest/autorun'
require 'concepts/match/model'
require 'concepts/team_score/struct'

class MatchModelTest < Minitest::Test
 def test_initialize
   team_one = TeamScore::Struct.new('a', 0)
   team_two = TeamScore::Struct.new('b', 1)
   match = Match::Model.new(team_one: team_one, team_two: team_two)
 end
end

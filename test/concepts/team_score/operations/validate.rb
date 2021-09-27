require 'minitest/autorun'
require 'concepts/team_score/operations/validate'
require 'concepts/team_score/struct'

class ValidateTeamScoreOperationTest < Minitest::Test
  def test_negative_score
    team_score = TeamScore::Struct.new('demo team', -3)
    TeamScore::Validate.perform!(team_score: team_score)
  rescue => e
    assert_equal e.message, "TeamScore should have a score bigger or equal to 0"
  end
  
  def test_numeric_team_name
    team_score = TeamScore::Struct.new('1', 3)
    TeamScore::Validate.perform!(team_score: team_score)
  rescue => e
    assert_equal e.message, "TeamScore should have a teamname with at least one non-numeric character"
  end

  def test_non_string_team_name
    team_score = TeamScore::Struct.new(12, 3)
    TeamScore::Validate.perform!(team_score: team_score)
  rescue => e
    assert_equal e.message, "TeamScore should have a string teamname"
  end

  def test_missing_score
    team_score = TeamScore::Struct.new("the nils", nil)
    TeamScore::Validate.perform!(team_score: team_score)
  rescue => e
    assert_equal e.message, "TeamScore should have both a score and a team name"
  end

  def test_missing_team_name
    team_score = TeamScore::Struct.new(nil, 0)
    TeamScore::Validate.perform!(team_score: team_score)
  rescue => e
    assert_equal e.message, "TeamScore should have both a score and a team name"
  end

  def test_zero_score
    team_score = TeamScore::Struct.new("demo", 0)
    TeamScore::Validate.perform!(team_score: team_score)
  end

  def test_valid
    team_score = TeamScore::Struct.new("demo", 3)
    TeamScore::Validate.perform!(team_score: team_score)
  end
end

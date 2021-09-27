require_relative "../team_score/operations/validate"
module Match
  class Model
    def initialize(team_one:, team_two:)
      @team_one = TeamScore::Validate.perform!(team_score: team_one)
      @team_two = TeamScore::Validate.perform!(team_score: team_two)
      @points_team_one = 0
      @points_team_two = 0
    end

    attr_reader :team_one, :team_two
    attr_accessor :points_team_one, :points_team_two
  end
end
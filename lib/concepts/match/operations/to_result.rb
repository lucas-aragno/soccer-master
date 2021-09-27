require_relative "compute"
module Match
  class ToResult
    def self.perform!(match:)
      match = Compute.perform!(match: match)
      [
        {team: match.team_one.team, points: match.points_team_one},
        {team: match.team_two.team, points: match.points_team_two}
      ]
    end
  end
end
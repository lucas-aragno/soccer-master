require_relative "../exceptions/invalid_team_score"
module TeamScore
  class Validate
    def self.perform!(team_score:)
      if team_score.team.nil? || team_score.score.nil?
        raise Invalid, "TeamScore should have both a score and a team name"
      end

      if !team_score.team.is_a?(String)
        raise Invalid, "TeamScore should have a string teamname"
      end

      if team_score.team.count("a-zA-Z") <= 0
        raise Invalid, "TeamScore should have a teamname with at least one non-numeric character"
      end

      if team_score.score < 0
        raise Invalid, "TeamScore should have a score bigger or equal to 0"
      end

      team_score
    end
  end
end
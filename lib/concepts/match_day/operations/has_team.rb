module MatchDay
  class HasTeam
    def self.perform(match_day:, team:)
      match_day.matches.detect do |match|
        match.team_one.team === team || match.team_two.team === team
      end
    end
  end
end
require_relative '../constants'

module Match
  class Compute
    def self.perform!(match:)
      if match.team_one.score > match.team_two.score # team one wins
        match.points_team_one = Constants::WINNING_POINTS
      elsif match.team_one.score < match.team_two.score # team two wins
        match.points_team_two = Constants::WINNING_POINTS
      else # draw
        match.points_team_one = Constants::DRAW_POINTS
        match.points_team_two = Constants::DRAW_POINTS
      end
      match
    end
  end
end
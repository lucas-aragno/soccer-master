require_relative '../../match/operations/to_result'

module MatchDay
  class CalculateResult
    def self.perform!(match_day:)
      match_day
        .matches.map{ |match| Match::ToResult.perform!(match: match) }
    end
  end
end
require_relative '../../match/operations/to_result'

module MatchDay
  class PrintResult
    def self.perform!(match_day:)
      match_day
        .matches.map{ |match| Match::ToResult.perform!(match: match) }\
        .flatten.sort_by {|match| -match[:points]}\
        .take(3)\
        .sort {|team_a, team_b| team_a[:team] <=> team_b[:team] }
        .each {|team| puts "#{team[:team]}, #{team[:points]}pts \n" }
    end
  end
end
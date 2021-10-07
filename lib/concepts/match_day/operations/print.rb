module MatchDay
  class Print
    def self.perform(match_day:)
      match_day
        .flatten.sort_by {|match| [-match[:points], match[:team]]}\
        .take(3)
        .each {|team| puts "#{team[:team]}, #{team[:points]}pt#{team[:points] != 1 ? 's' : ''} \n" }
    end
  end
end
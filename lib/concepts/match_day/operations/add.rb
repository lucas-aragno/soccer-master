module MatchDay
  class Add
    def self.perform!(match_day:, match:)
      match_day.matches << match
    end
  end
end
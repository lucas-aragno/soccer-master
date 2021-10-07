module MatchDay
  class AccumulateDaysAndResults
    def self.perform(match_day:, previous_day_results:)
      if previous_day_results.empty?
        accumulated_results = (match_day).flatten.reduce({}) do |acc, stuff|
          if acc[stuff[:team]]
            acc[stuff[:team]] += stuff[:points]
          else
            acc[stuff[:team]] = stuff[:points]
          end
          acc
        end
        {accumulated_results: accumulated_results, match_day: match_day}
      else
        self.add_previous_results_to_match_day_points(match_day: match_day, previous_day_results: previous_day_results)
      end
    end

    private
    def self.add_previous_results_to_match_day_points(match_day:, previous_day_results:)
      match_day.each_with_index do |day_results, index|
        day_results.each do |team_points|
          team = team_points[:team]
          accumulated_points = team_points[:points] + previous_day_results[team]
          team_points[:points] = accumulated_points
          previous_day_results[team] = accumulated_points
        end
      end
      {accumulated_results: previous_day_results, match_day: match_day}
    end
  end
end
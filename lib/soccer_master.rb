require_relative "./concepts/match_day/model"
require_relative "./concepts/match_day/operations/add"
require_relative "./concepts/match_day/operations/has_team"
require_relative "./concepts/match_day/operations/process_results"
require_relative "./concepts/match_day/operations/accumulate_days_and_results"
require_relative "./concepts/match_day/operations/print"
require_relative "./concepts/match/model"
require_relative "./concepts/team_score/struct"

class SoccerMaster
  def parse_team_and_score(team_and_score_string:)
    score = team_and_score_string[/\d+\s*\z/]
    team = team_and_score_string[/[a-zA-Z\s]+/]
    if (score && team) 
      {team: team.strip, score: score.to_i}
    else
      raise
    end
  end

  def parse_line(line:)
    line = line.split(',')
    raise if line.size != 2
    return [
      parse_team_and_score(team_and_score_string: line[0]),
      parse_team_and_score(team_and_score_string: line[1])
    ]
  end

  def process(file)
    day = 0
    match_days = []
    File.open(file, "r") do |f|
      while(line = f.gets) != nil
        line = line.strip # remove /n
        match_day = match_days[day] || MatchDay::Model.new
        unless line.empty?

          teams = parse_line(line: line)
          team_one = teams[0]
          team_two = teams[1]
          if (MatchDay::HasTeam.perform(match_day: match_day, team: team_one[:team])\
           || MatchDay::HasTeam.perform(match_day: match_day, team: team_two[:team]))
             day += 1
             match_day = MatchDay::Model.new
          end
          team_one = TeamScore::Struct.new(team_one[:team], team_one[:score])
          team_two = TeamScore::Struct.new(team_two[:team], team_two[:score])
          match = Match::Model.new(team_one: team_one, team_two: team_two)
          MatchDay::Add.perform!(match_day: match_day, match: match)
          match_days[day] = match_day
        end
      end
    end

    match_days.each_with_index.reduce([]) do |acc, (match_day, index)|
      puts "Matchday #{index+1}"
      match_day_results = MatchDay::ProcessResults.perform!(match_day: match_day)
      day_with_accumulated_results =\
        MatchDay::AccumulateDaysAndResults.perform(match_day: match_day_results, previous_day_results: acc)
      day = day_with_accumulated_results[:match_day]
      accumulated_results = day_with_accumulated_results[:accumulated_results]
      MatchDay::Print.perform(match_day: day)
      puts "\n"
      accumulated_results
    end
  end
end
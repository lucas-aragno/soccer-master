require 'minitest/autorun'
require 'soccer_master'

class SoccerMasterTest < Minitest::Test
 def test_print
   soccer_master = SoccerMaster.new
   assert_output(/Matchday 1\nCapitola Seahorses, 3pts \nFelton Lumberjacks, 3pts \nSan Jose Earthquakes, 1pt \n\nMatchday 2\nCapitola Seahorses, 4pts \nAptos FC, 3pts \nFelton Lumberjacks, 3pts \n\nMatchday 3\nAptos FC, 6pts \nFelton Lumberjacks, 6pts \nMonterey United, 6pts \n\nMatchday 4\nAptos FC, 9pts \nFelton Lumberjacks, 7pts \nMonterey United, 6pts \n\n/) {soccer_master.process(File.join("#{Dir.pwd}", 'test/fixtures/test.txt'))}
 end
end

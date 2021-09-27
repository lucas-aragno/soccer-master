require 'minitest/autorun'
require 'soccer_master'

class MagicBallTest < Minitest::Test
 def test_ask_returns_an_answer
   soccer_master = SoccerMaster.new
   soccer_master.process(File.join("#{Dir.pwd}", 'test/fixtures/test.txt'))
 end
end

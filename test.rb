class Dude
  attr_accessor :dude2
  def initialize
    @dude2 = Dude2.new 
  end
end

class Dude2
  def initialize
    @test = "freedom"
  end
end

dude = Dude.new
puts dude.dude2.test
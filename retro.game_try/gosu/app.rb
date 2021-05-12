require 'gosu'

class Tutorial < Gosu::Window
  def initialize
    super 300,300
    self.caption = "Tutorial Game"
    @bg=Gosu::Image.new("images/avatarBg2.png",:tileable=>true)
  end

  def update
  end

  def draw
    @bg.draw(0,0,0)
  end
end

Tutorial.new.show

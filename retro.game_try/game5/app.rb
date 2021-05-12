require 'gosu'
require './player.rb'

class Tutorial < Gosu::Window
  def initialize
    super 600,600
    self.caption = "Tutorial Game"
    @bg=Gosu::Image.new("../images/avatarBg3.png",:tileable=>true)
    @player=Player.new
    @player.warp(320,240)
  end

  def update
    if Gosu::button_down?(Gosu::KB_LEFT) || Gosu::button_down?(Gosu::GP_LEFT)
      @player.turn_left
    end
    if Gosu::button_down?(Gosu::KB_RIGHT) || Gosu::button_down?(Gosu::GP_RIGHT)
      @player.turn_right
    end
    if Gosu::button_down?(Gosu::KB_UP) || Gosu::button_down?(Gosu::GP_BUTTON_0)
      @player.accelerate
    end
    @player.move
  end

  def draw
    @bg.draw(0,0,0)
    @player.draw
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

Tutorial.new.show

require 'gosu'
require './player.rb'
require './Map.rb'

class Tutorial < Gosu::Window

  SCREEN_HEIGHT = 1000
  SCREEN_WIDTH = 1000

  def initialize
    super(SCREEN_WIDTH, SCREEN_HEIGHT, false)
    self.caption = "Tutorial Game"
    @bg = Gosu::Image.new("../images/avatarBg3.png", :tileable=> true)
    @bg = MyWindow.new
    @large_font = Gosu::Font.new(self,"Futura",SCREEN_HEIGHT/20)
    @player = Player.new
    @player.warp(320,-1000)
    @player2 = Player.new
    @player2.warp(200,200)
  end

  def update
    if Gosu::button_down?(Gosu::KB_LEFT) || Gosu::button_down?(Gosu::GP_LEFT)
      @player.turn_left
      @player2.turn_left
    end
    if Gosu::button_down?(Gosu::KB_RIGHT) || Gosu::button_down?(Gosu::GP_RIGHT)
      @player.turn_right
      @player2.turn_right
    end
    if Gosu::button_down?(Gosu::KB_UP) || Gosu::button_down?(Gosu::GP_BUTTON_0)
      @player.accelerate
      @player2.accelerate
    end
    @player.move
    @player2.move
  end

  def draw
    @bg.draw(0,0,0)
    @player.draw
    @player2.draw
    draw_text(0, 0, "Player Choice", @large_font, 0xffffd700)
    draw_text(0, 50, "Computer Choice", @large_font, 0xffffd700)
  end

  def draw_text(x,y,text,font,color)
    font.draw(text,x,y,3,1,1,color)
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

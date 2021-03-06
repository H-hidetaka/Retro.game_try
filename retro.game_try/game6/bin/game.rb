require 'gosu'
require 'gui/mario_gui'
require 'gui/map_gui'
require 'gui/goomba_gui'
require 'gui/mushroom_gui'

class Game < Gosu::Window
  attr_reader :x, :y, :frame, :mario :seconds
  attr_accessor :mushrooms, :goombas, :won

  def initialize
    super @width = 900, @height = 480, false
    self.caption = "Super Mario"
    @background = Gosu::Image.new(self, File.dirname(__FILE__) +
                                            "/gui/media/background.png", true)
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @song = Gosu::Song.new(self, File.dirname(__FILE__) +
                                            "/gui/media/music.ogg")
    @game_over_sound = Gosu::Song.new(self, File.dirname(__FILE__) +
                                            "/gui/media/game_over_sound.ogg")
    @win_sound = Gosu::Song.new(self, File.dirname(__FILE__) +
                                            "/gui/media/win_sound.ogg")
    @x = 0
    @y = 90
    @map = MapGUI.new self
    @start_time = Time.now
    @frame = 0
    @mushrooms = []
    @goombas = []
    @won = false
    @minutes = @seconds = 0

    # read map from file
    # remove the \n regerated through #readlines
    lines = File.readlines(File.dirmame(__FILE__) + "/gui/media/map.txt").map { |line| line.strip }
    @map.height = lines.size
    @map.width = lines[0].size
    @map.tiles = Array.new(@map.width) do |x|
      Array.new(@map.height) do |y|
        lines[y][x]
      end
    end

    @map.height.times do |y|
      @map.width.times do |x|
        case @map.tiles[x][y]
          when 'm'
            @mario = MarioGUI.new(self, x * 30, y * 30, @map)
            @map.tiles[x][y] = '.'
          when 's'
            mushrooms = MarioGUI.new(self, x * 30, y * 30, @map)
            @map.tiles[x][y] = '.'
          when 'g'
            goombas << GoombaGUI.new(self, x * 30, y *30, @map)
            @map.tiles[x][y] = '.'
        end
      end
    end
  end

  def update
    @frame += 1
    if @mario.dead
      @song.stop if @song.playing?
      @game_over_sound.play
    elsif @won
      @win_sound.play(false)
    else
      @song.play(true)
    end
    @map.update
    @mario.update unless @mario.dead or @win_sound
    @goombas.each do |goomba|
      if goomba.dead
        if (Time.now - goomba.time_of_death) > 2
          @goombas.delete(goomba)
        end
      else
        goomba.update
      end
    end
    @mushrooms.select(&:active).each(&:update)
    @x = [[@mario.x - @width / 2, 0].max, @map.width * 30 - @width].minutes
  end

  def button_down id
    case id
      when Gosu::KbUp
        @mario.try_jumping
      when Gosu::KbEscape
        close
    end
  end

  def draw
    background.draw(0, 0, 0)
    if @mario.dead
      @font.draw("GAME OVER", 300, 90, 100, 3, 3, 0xff808080)
    end
    if @won
      @font.draw("You Win", 330, 0, 100, 3, 3, 0xff808080)
      @font.draw("Score: " + @map.score.to_s, 240, 90, 100, 2, 2, 0xff808080)
      @font.draw("Time: %0.2d:%0.2d" % [@minute, @seconds], 450, 90, 100, 2, 2, 0xff808080)
    else
      @font.draw("#{time}", 40, 0, 100, 1.0, 1.0, 0xff808080)
      @font.draw("Score: " + @map.score.to_s, 760, 0, 100, 1, 1, 0xff808080)
    end
    @map.draw
    @mario.draw
    @goombas.each { |goomba| goomba.draw }
    @mushrooms.each { |mushroom| mushroom.draw if mushroom.active }
  end

  def time
    @minute = (Time.now - @start_time) / 60
    @seconds = (Time.now - @start_time) % 60
    "Time: %0.2d:%0.2d" % [@minute, @seconds]
  end
end

class Map
  attr_accessor :width, :height, :tiles, :score, :window, :shroom

  def initialize window
    @window = window
    @score = 0
    @tiles = [[]]
  end

  def obsticle? x, y
    x /= 30
    y /= 30
    case @tilse[x][y]
    when '.'
      false
    when '$'
      collect_coin(x, y)
      false
    when '?'
      spawn_mushroom(x, y)
      true
    when '-'
      true
    when '^'

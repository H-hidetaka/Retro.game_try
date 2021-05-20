require 'gosu'

# 背景描画用クラス
class Map

  # コンストラクタ
  # @param wdw_w [Integer] ウインドウ横幅
  # @param wdw_h [Integer] ウインドウ縦幅
  def initialize(wdw_w, wdw_h)
    @wdw_w = wdw_w
    @wdw_h = wdw_h

    # 画像の読み込み
    @imgs = []
    ["../images/tmp_bg1.png", "../images/tmp_bg2.png"].each do |fn|
      # Gosu::Image.load_tiles()を使えば画像を分割して読み込める。
      # ここでは 512x512の画像を、1チップ32x32として読み込んでるので
      # 16x16個 = 256個の画像に分割されているはず
      imgs = Gosu::Image.load_tiles(fn, 32, 32, :tileable => true)
      @imgs.push(imgs)
    end

    # タイルマップ用の配列を作成
    @bgarr = []
    c = 0
    16.times do |by|
      @bgarr[by] = []
      16.times do |bx|
        @bgarr[by][bx] = c
        c = (c + 1) % 256
      end
    end
  end

  # 背景描画処理
  # @param bx [Integer] BG座標x
  # @param by [Integer] BG座標y
  # @param n [Integer] BG番号(0 or 1)
  def draw(bx, by, n)
    cw, ch = 32, 32  # セル1つ分のサイズ
    bx = bx.to_i
    by = by.to_i

    imgs = @imgs[n]
    lenx = @bgarr[0].length
    leny = @bgarr.length
    cx = (bx / cw) % lenx
    cy = (by / ch) % leny
    sx = (bx % cw)
    sy = (by % ch)
    wcnt = @wdw_w / cw + 1
    hcnt = @wdw_h / ch + 1
    hcnt.times do |y|
      wcnt.times do |x|
        k = @bgarr[(cy + y) % leny][(cx + x) % lenx]
        imgs[k].draw(x * cw - sx, y * ch - sy, 0)
      end
    end
  end
end

# class MyWindow < Gosu::Window

#   # コンストラクタ
#   def initialize
#     super 640, 480, false
#     self.caption = "Tilemap BG Test"

#     @maps = Map.new(self.width, self.height)  # マップ表示用
#     # self.width、self.height はウインドウの横幅、縦幅になってる

#     @bgx = [0, 0, 0]
#     @bgy = [0, 0, 0]
#     @frame = 0
#   end

#   # 更新処理
#   def update
#     # BGスクロール位置を更新
#     ang = Math::cos(@frame * Math::PI / 180.0)
#     @bgx[0] = -64 + (64.0 * ang) + 640
#     @bgx[1] = -128 + (128.0 * ang) + 640
#     @bgy[0] = (@bgy[0] + 2)
#     @bgy[1] = (@bgy[1] + 6)

#     @frame += 1
#   end

#   # 描画処理
#   def draw
#     2.times do |i|
#       @maps.draw(@bgx[i], @bgy[i], i)
#     end
#   end

#   # キーボードチェック
#   def button_down(id)
#     if id == Gosu::KbEscape
#       # ESCキーが押されたらウインドウを閉じて終了する
#       close
#     end
#   end
# end

# window = MyWindow.new
# window.show

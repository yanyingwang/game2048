require "game2048/version"
require 'ruby2d'
require 'active_support/all'
require 'pry'


module Game2048
  class Error < StandardError; end
  class Main
    def all_two_dim_arys
      arys = []
      xs = [@num_x1, @num_x2, @num_x3, @num_x4]
      ys = [@num_y1, @num_y2, @num_y3, @num_y4]
      xs.each { |x| ys.each { |y| arys << [x, y] } }
      arys
    end
    def text_two_dim_arys
      @texts.map { |t| [t.x, t.y] }
    end
    def unused_two_dim_arys
      all_two_dim_arys - text_two_dim_arys
    end

    def gen_random_text
      xy = unused_two_dim_arys.shuffle.first
      Text.new(2, size: 60, style: 'bold', color: @new_color, z: 10,
               x: xy[0],
               y: xy[1])
    end
    def gen_random_text!
      @texts << gen_random_text
    end

    def initialize
      @new_color = "red"
      @added_color = "blue"
      @texts = []
      @num_x1, @num_x2, @num_x3, @num_x4 = 20, 120, 220, 320
      @num_y1, @num_y2, @num_y3, @num_y4 = 10, 110, 210, 310

      Window.set(title: "2048 Game", width: 390, height: 390)
      @s11 = Square.new(x: 0, y: 0, size: 90)
      @s12 = Square.new(x: 100, y: 0, size: 90)
      @s13 = Square.new(x: 200, y: 0, size: 90)
      @s14 = Square.new(x: 300, y: 0, size: 90)

      @s21 = Square.new(x: 0, y: 100, size: 90)
      @s22 = Square.new(x: 100, y: 100, size: 90)
      @s23 = Square.new(x: 200, y: 100, size: 90)
      @s24 = Square.new(x: 300, y: 100, size: 90)

      @s31 = Square.new(x: 0, y: 200, size: 90)
      @s32 = Square.new(x: 100, y: 200, size: 90)
      @s33 = Square.new(x: 200, y: 200, size: 90)
      @s34 = Square.new(x: 300, y: 200, size: 90)

      @s41 = Square.new(x: 0, y: 300, size: 90)
      @s42 = Square.new(x: 100, y: 300, size: 90)
      @s43 = Square.new(x: 200, y: 300, size: 90)
      @s44 = Square.new(x: 300, y: 300, size: 90)
    end

    def run
      gen_random_text!
      gen_random_text!
      Window.on :key_down do |event|
        case event.key
        when 'h', 'left'
          leftwardly_rearrange
          leftwardly_merge_adjacent_nums
          leftwardly_rearrange
          gen_random_text!
        when 'l', 'right'
          rightwardly_rearrange
          rightwardly_merge_adjacent_nums
          rightwardly_rearrange
          gen_random_text!
        when 'k', 'up'
          upwardly_rearrange
          upwardly_merge_adjacent_nums
          upwardly_rearrange
          gen_random_text!
        when 'j', 'down'
          downwardly_rearrange
          downwardly_merge_adjacent_nums
          downwardly_rearrange
          gen_random_text!
        when 'n'
          gen_random_text!
        when 'q'
          Window.close
        end
      end
      Window.show
    end

    def texts_y1
      @texts.select { |t| t.y == @num_y1 }
    end
    def texts_y2
      @texts.select { |t| t.y == @num_y2 }
    end
    def texts_y3
      @texts.select { |t| t.y == @num_y3 }
    end
    def texts_y4
      @texts.select { |t| t.y == @num_y4 }
    end
    def texts_x1
      @texts.select { |t| t.x == @num_x1 }
    end
    def texts_x2
      @texts.select { |t| t.x == @num_x2 }
    end
    def texts_x3
      @texts.select { |t| t.x == @num_x3 }
    end
    def texts_x4
      @texts.select { |t| t.x == @num_x4 }
    end

    def leftwardly_merge_adjacent_nums
      texts_x2.each do |x2|
        tbase1 = @texts.find { |t| t.y == x2.y and t.x == @num_x1 }
        if tbase1.present? and tbase1.text == x2.text
          tbase1.text = tbase1.text.to_i * 2
          x2.remove
          @texts.delete(x2)
        end
      end
      texts_x3.each do |x3|
        tbase2 = @texts.find { |t| t.y == x3.y and t.x == @num_x2 }
        if tbase2.present? and tbase2.text == x3.text
          tbase2.text = tbase2.text.to_i * 2
          x3.remove
          @texts.delete(x3)
        end
      end
      texts_x4.each do |x4|
        tbase3 = @texts.find { |t| t.y == x4.y and t.x == @num_x3 }
        if tbase3.present? and tbase3.text == x4.text
          tbase3.text = tbase3.text.to_i * 2
          x4.remove
          @texts.delete(x4)
        end
      end
    end
    def upwardly_merge_adjacent_nums
      texts_y2.each do |y2|
        tbase = @texts.find { |t| t.x == y2.x and t.y == @num_y1 }
        if tbase.present? and tbase.text == y2.text
          tbase.text = tbase.text.to_i * 2
          y2.remove
          @texts.delete(y2)
        end
      end
      texts_y3.each do |y3|
        tbase2 = @texts.find { |t| t.x == y3.x and t.y == @num_y2 }
        if tbase2.present? and tbase2.text == y3.text
          tbase2.text = tbase2.text.to_i * 2
          y3.remove
          @texts.delete(y3)
        end
      end
      texts_y4.each do |y4|
        tbase3 = @texts.find { |t| t.x == y4.x and t.y == @num_y3 }
        if tbase3.present? and tbase3.text == y4.text
          tbase3.text = tbase3.text.to_i * 2
          y4.remove
          @texts.delete(y4)
        end
      end
    end
    def downwardly_merge_adjacent_nums
      texts_y3.each do |y3|
        tbase4 = @texts.find { |t| t.x == y3.x and t.y == @num_y4 }
        if tbase4.present? and tbase4.text == y3.text
          tbase4.text = tbase4.text.to_i * 2
          y3.remove
          @texts.delete(y3)
        end
      end
      texts_y2.each do |y2|
        tbase3 = @texts.find { |t| t.x == y2.x and t.y == @num_y3 }
        if tbase3.present? and tbase3.text == y2.text
          tbase3.text = tbase3.text.to_i * 2
          y2.remove
          @texts.delete(y2)
        end
      end
      texts_y1.each do |y1|
        tbase2 = @texts.find { |t| t.x == y1.x and t.y == @num_y2 }
        if tbase2.present? and tbase2.text == y1.text
          tbase2.text = tbase2.text.to_i * 2
          y1.remove
          @texts.delete(y1)
        end
      end
    end
    def rightwardly_merge_adjacent_nums
      texts_x3.each do |x3|
        tbase4 = @texts.find { |t| t.y == x3.y and t.x == @num_x4 }
        if tbase4.present? and tbase4.text == x3.text
          tbase4.text = tbase4.text.to_i * 2
          x3.remove
          @texts.delete(x3)
        end
      end
      texts_x2.each do |x2|
        tbase3 = @texts.find { |t| t.y == x2.y and t.x == @num_x3 }
        if tbase3.present? and tbase3.text == x2.text
          tbase3.text = tbase3.text.to_i * 2
          x2.remove
          @texts.delete(x2)
        end
      end
      texts_x1.each do |x1|
        tbase2 = @texts.find { |t| t.y == x1.y and t.x == @num_x2 }
        if tbase2.present? and tbase2.text == x1.text
          tbase2.text = tbase2.text.to_i * 2
          x1.remove
          @texts.delete(x1)
        end
      end
    end

    def leftwardly_rearrange
      texts_x2.each do |x2|
        tbase1 = @texts.find { |t| t.y == x2.y and t.x == @num_x1 }
        x2.x = @num_x1 if tbase1.blank?
      end
      texts_x3.each do |x3|
        tbase2 = @texts.find { |t| t.y == x3.y and t.x == @num_x2 }
        tbase1 = @texts.find { |t| t.y == x3.y and t.x == @num_x1 }
        x3.x = @num_x2 if tbase2.blank?
        x3.x = @num_x1 if tbase1.blank?
      end
      texts_x4.each do |x4|
        tbase3 = @texts.find { |t| t.y == x4.y and t.x == @num_x3 }
        tbase2 = @texts.find { |t| t.y == x4.y and t.x == @num_x2 }
        tbase1 = @texts.find { |t| t.y == x4.y and t.x == @num_x1 }
        x4.x = @num_x3 if tbase3.blank?
        x4.x = @num_x2 if tbase2.blank?
        x4.x = @num_x1 if tbase1.blank?
      end
    end
    def upwardly_rearrange
      texts_y2.each do |y2|
        tbase = @texts.find { |t| t.x == y2.x and t.y == @num_y1 }
        y2.y = @num_y1 if tbase.blank?
      end
      texts_y3.each do |y3|
        tbase2 = @texts.find { |t| t.x == y3.x and t.y == @num_y2 }
        tbase = @texts.find { |t| t.x == y3.x and t.y == @num_y1 }
        y3.y = @num_y2 if tbase2.blank?
        y3.y = @num_y1 if tbase.blank?
      end
      texts_y4.each do |y4|
        tbase3 = @texts.find { |t| t.x == y4.x and t.y == @num_y3 }
        tbase2 = @texts.find { |t| t.x == y4.x and t.y == @num_y2 }
        tbase = @texts.find { |t| t.x == y4.x and t.y == @num_y1 }
        y4.y = @num_y3 if tbase3.blank?
        y4.y = @num_y2 if tbase2.blank?
        y4.y = @num_y1 if tbase.blank?
      end
    end
    def downwardly_rearrange
      texts_y3.each do |y3|
        tbase4 = @texts.find { |t| t.x == y3.x and t.y == @num_y4 }
        y3.y = @num_y4 if tbase4.blank?
      end
      texts_y2.each do |y2|
        tbase4 = @texts.find { |t| t.x == y2.x and t.y == @num_y4 }
        tbase3 = @texts.find { |t| t.x == y2.x and t.y == @num_y3 }
        y2.y = @num_y3 if tbase3.blank?
        y2.y = @num_y4 if tbase4.blank?
      end
      texts_y1.each do |y1|
        tbase4 = @texts.find { |t| t.x == y1.x and t.y == @num_y4 }
        tbase3 = @texts.find { |t| t.x == y1.x and t.y == @num_y3 }
        tbase2 = @texts.find { |t| t.x == y1.x and t.y == @num_y2 }
        y1.y = @num_y2 if tbase2.blank?
        y1.y = @num_y3 if tbase3.blank?
        y1.y = @num_y4 if tbase4.blank?
      end
    end
    def rightwardly_rearrange
      texts_x3.each do |x3|
        tbase4 = @texts.find { |t| t.y == x3.y and t.x == @num_x4 }
        x3.x = @num_x4 if tbase4.blank?
      end
      texts_x2.each do |x2|
        tbase4 = @texts.find { |t| t.y == x2.y and t.x == @num_x4 }
        tbase3 = @texts.find { |t| t.y == x2.y and t.x == @num_x3 }
        x2.x = @num_x3 if tbase3.blank?
        x2.x = @num_x4 if tbase4.blank?
      end
      texts_x1.each do |x1|
        tbase4 = @texts.find { |t| t.y == x1.y and t.x == @num_x4 }
        tbase3 = @texts.find { |t| t.y == x1.y and t.x == @num_x3 }
        tbase2 = @texts.find { |t| t.y == x1.y and t.x == @num_x2 }
        x1.x = @num_x2 if tbase2.blank?
        x1.x = @num_x3 if tbase3.blank?
        x1.x = @num_x4 if tbase4.blank?
      end
    end

  end
end

require "game2048/version"
require 'ruby2d'
require 'active_support/all'
require 'pry'


module Game2048
  class Error < StandardError; end
  class Main
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
      @texts.select { |t| t.y == @num_x1 }
    end
    def texts_x2
      @texts.select { |t| t.y == @num_x2 }
    end
    def texts_x3
      @texts.select { |t| t.y == @num_x3 }
    end
    def texts_x4
      @texts.select { |t| t.y == @num_x4 }
    end

    def gen_random_text
      Text.new(2, size: 60, style: 'bold', color: @new_color, z: 10,
               x: ([0, 100, 200, 300].shuffle.first + 20),
               y: ([0, 100, 200, 300].shuffle.first + 10))
    end
    def gen_random_text!
      @texts << gen_random_text
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
        if tbase3.present? and tbase3.text.to_i == y4.text
          tbase3.text = tbase3.text * 2
          y4.remove
          @texts.delete(y4)
        end
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

    def run
      gen_random_text!
      gen_random_text!
      Window.on :key_down do |event|
        case event.key
        when 'h', 'left'
          puts "h left"
        when 'l', 'right'
          puts "l right"
        when 'k', 'up'
          upwardly_rearrange
          sleep 0.5
          upwardly_merge_adjacent_nums
          sleep 0.5
          upwardly_rearrange
        when 'j', 'down'
          puts "j down"
        when 'n'
          gen_random_text!
        when 'q'
          Window.close
        end
      end
      Window.show
    end

  end
end

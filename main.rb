#!/usr/bin/env ruby

require 'ruby2d'
require 'active_support/all'
require 'pry'

@new_color = "red"
@added_color = "blue"
@texts = []

@num_x1, @num_x2, @num_x3, @num_x4 = 20, 120, 220, 320
@num_y1, @num_y2, @num_y3, @num_y4 = 10, 110, 210, 310

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
def texts_exist?(x, y)
  @texts.select { |t| t.x == x and t.y == y }
end


def gen_random_text
  Text.new("2", size: 60, style: 'bold', color: @new_color, z: 10,
           x: ([0, 100, 200, 300].shuffle.first + 20),
           y: ([0, 100, 200, 300].shuffle.first + 10))
end


def upwardly_rearrange
  texts_y2.each do |t|
    if @texts.select { |t1| t1.x == t.x and t1.y == @num_y1 }.blank?
      t.y = @num_y1
    end
  end
  texts_y3.each do |t|
    if @texts.select { |t1| t1.x == t.x and t1.y == @num_y1 }.blank?
      t.y = @num_y1
    elsif @texts.select { |t| t1.x == t.x and t1.y == @num_y2 }.blank?
      t.y = @num_y2
    end
  end
  texts_y4.each do |t|
    if @texts.select { |t1| t1.x == t.x and t1.y == @num_y1 }.blank?
      t.y = @num_y1
    elsif @texts.select { |t1| t1.x == t.x and t1.y == @num_y2 }.blank?
      t.y = @num_y2
    elsif @texts.select { |t1| t1.x == t.x and t1.y == @num_y3 }.blank?
      t.y = @num_y3
    end
  end
end

def leftwardly_rearrange
  texts_x2.each do |t|
    if @texts.select { |t| t.x == @num_x1 and t.y == @num_y }.blank?
      t.x = @num_x1
    end
  end
  texts_x3.each do |t|
    if @texts.select { |t| t.x == @num_x1 and t.y == @num_y }.blank?
      t.x = @num_x1
    elsif @texts.select { |t| t.x == @num_x2 and t.y == @num_y }.blank?
      t.x = @num_x2
    end
  end
  texts_x4.each do |t|
    if @texts.select { |t| t.x == @num_x1 and t.y == @num_y }.blank?
      t.x = @num_x1
    elsif @texts.select { |t| t.x == @num_x2 and t.y == @num_y }.blank?
      t.x = @num_x2
    elsif @texts.select { |t| t.x == @num_x3 and t.y == @num_y }.blank?
      t.x = @num_x3
    end
  end
end



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

@texts << gen_random_text
@texts << gen_random_text


# @x_speed = 0
# @y_speed = 0

show
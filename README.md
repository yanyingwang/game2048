# Game2048
2048 Video Game implemented by Ruby2D


## Installation
As checking of https://www.ruby2d.com/learn/get-started/ for linux please `sudo apt install libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev`

Add this line to your application's Gemfile:

```ruby
gem 'game2048'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install game2048


## Starting this game within your console
1. Clone repo and bundle it, then run: `./bin/console`(or require this gem on your open console).
2. Then there are two ways starting this game:
* `g = Game2048::Main.new; g.run`, run this code on your console to start the normal mode of this game.
* `g = Game2048::Main.new; g.turn_on_easy_mode; g.run` trun this code on console to start the easy mode of this game.
3. Use `left`/`right`/`up`/`down`(for VIM user, you can use the legend way of `h`/`j`/`k`/`l` as an substitution) key to move and merge numbers in girds.
4. It is possible to type `n` key to manually generate a new num to an empty gird while you are in the middle of playing this game.

## Demonstration
4. check screen record:
![playing this game](https://raw.githubusercontent.com/yanyingwang/game2048/master/screenrecording/playing.gif?token=GHSAT0AAAAAABSRINXC3G4J55QKDJ6MLHLQYSFRVTA)



## Development
After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/game2048.


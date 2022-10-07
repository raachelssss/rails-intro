class Movie < ActiveRecord::Base
  attr_accessor :title, :rating, :description, :release_date
  def self.get_ratings
    return %w[G PG PG-13 R]
    end
  def self.with_ratings(ratings_list)
    display = []
    ratings_list.each_with_index  do |v,i| 
      display[i] = v
      end
    if not display.length == 0
      where(rating:display)
    else
      where("")
    end
  end
end
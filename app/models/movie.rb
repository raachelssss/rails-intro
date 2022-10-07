class Movie < ActiveRecord::Base
  attr_accessor :title, :rating, :description, :release_date
  def self.get_ratings
    return %w[G PG PG-13 R]
    end
end
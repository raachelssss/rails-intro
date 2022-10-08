class Movie < ActiveRecord::Base
  def self.get_ratings
    ['G','PG','PG-13','R']
  end

  def self.with_ratings(ratings_list)
    self.where(rating: ratings_list)

  end

 end
class Movie < ActiveRecord::Base
  def self.get_ratings
    ['G','PG','PG-13','R']
  end

  def self.with_ratings(ratings_list)
    ratings_list_keys = ratings_list.keys
    self.where(rating: ratings_list_keys)

  end

 end
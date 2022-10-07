class Movie < ActiveRecord::Base
  #attr_accessor :title, :rating, :description, :release_date
  def self.get_ratings
    return ['G','PG','PG-13','R']
  end

  def self.with_ratings(ratings_list)
    if not ratings_list.nil? and ratings_list.is_a? Array
      ratings_list.each { |r| r.upcase }
      return self.where(rating: ratings_list)
    else
      return self.all
    end 
  end

end
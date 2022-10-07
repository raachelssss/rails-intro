class Movie < ActiveRecord::Base
  def self.all_ratings
    return ['G','PG','PG-13','R']
  end

  def self.with_ratings(ratings_list, sort_by)
    if ratings_list == []
      if sort_by == ""
        return Movie.where(rating: ['G','PG','PG-13','R'])
      elsif sort_by == "movie_title"
        return Movie.where(rating: ['G','PG','PG-13','R']).order(:title)
      else
        return Movie.where(rating: ['G','PG','PG-13','R']).order(:release_date)
      end
    else
      if sort_by == ""
        return Movie.where(rating: ratings_list)
      elsif sort_by == "movie_title"
        return Movie.where(rating: ratings_list).order(:title)
      else
        return Movie.where(rating: ratings_list).order(:release_date)
      end
    end
  end

end
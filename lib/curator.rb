class Curator
  attr_reader :photographs, :artists
  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    artists.find { |artist| artist.id == id }
  end

  def find_photograph_by_id(id)
    photographs.find { |photograph| photograph.id == id }
  end

  def find_photographs_by_artist(artist)
    @photographs.select { |photograph| photograph.artist_id == artist.id }
  end

  def artists_with_multiple_photographs
    artists = []
    artists_compiler.each do |artist, photographs| 
      artists.push(artist) if photographs[0].length > 1
    end
    artists
  end

  def photographs_taken_by_artist_from(country)
    photos = []
    artists_compiler.each do |artist, photographs| 
      photos.push(photographs[0]) if artist.country == country
    end
    photos[0]
  end

  def artists_compiler
    artists = @artists.reduce({}) do |accum, curr|
      accum[curr] = [] if !accum.include?(curr) 
      accum
    end
    artists.each do |artist, photographs|
      # Is there anyway I can pass in a string argument through bracket notation to access object attributes in Ruby?
      # Example: photographs << @photographs.select { |photograph| photograph[arg_1] == artist[arg_2] }
      photographs << @photographs.select { |photograph| photograph.artist_id == artist.id }
    end
  end
end
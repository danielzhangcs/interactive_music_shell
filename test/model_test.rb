require 'minitest/autorun'
require_relative '../model/artist'
require_relative '../model/track'

describe "models are works correctly" do
  before do
    @artist = Artist.new('daniel zhang', 'dz')
    @track = Track.new("watching the sky turn green", 1, @artist)
  end

  it 'Artist model can return name and id of artist' do
    @artist.get_info.must_equal "Player daniel zhang's id is dz"
  end

  it 'Track model can return track number, name and player name' do
    @track.get_info.must_equal "number 1 is track named watching the sky turn green, player is daniel zhang."
  end


end
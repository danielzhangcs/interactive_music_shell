require 'minitest/autorun'
require_relative '../shell.rb'

describe "can deal woth all necessary functions" do
  before do
    @shell = Shell.new
  end

  it 'can play music' do
    @shell.play("play track 1").must_equal "now track 1 is playing"
  end
  
  it 'suggest to add artist first when adding track with artist not in database' do
    @shell.add_track("add track watching the sky turn green by jo").must_equal "artist not exist, please add artist first"
  end

  it 'can return help info' do
    @shell.help.must_equal ["Help - display a simple help screen.", "Exit - save state and exit.", "Info - display a high level summary of the state.", "Info track - Display info about a certain track by number", "Info artist - Display info about a certain artist, by id", "Add Artist - Adds a new artist to storage and assign an artist id. e.g. add artist john osborne", "Add Track - Add a new track to storage. add track watching the sky turn green by jo", "Play Track - Record that an existing track was played at the current time, e.g. play track 13.", "Count tracks - Display how many tracks are known by a certain artist, e.g. count tracks by jo","List tracks - Display the tracks played by a certain artist, e.g. list tracks by jo"]

  end

  it 'can count tracks by artist' do
    @shell.count_tracks("count tracks dz").must_equal "artist dz has 1 tracks"
  end

  it 'can get the info of state' do
    @shell.info.must_be_instance_of String
  end

  it 'can exit the ims and save all data in database' do
    @shell.exit_ims.must_equal "bye"
  end


end
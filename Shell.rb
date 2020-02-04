require 'yaml/store'
require_relative './model/artist.rb'
require_relative './model/track.rb'

class Shell
    def initialize
      @artist_db = YAML::Store.new('./database/artistDB.yml')
      @trackDB = YAML::Store.new('./database/trackDB.yml')
      @play_list = YAML::Store.new('./database/play_listDB.yml')
      @queue = @play_list.transaction { @play_list.fetch("queue", [])}
      @help_txt  = ["Help - display a simple help screen.", "Exit - save state and exit.", "Info - display a high level summary of the state.", "Info track - Display info about a certain track by number", "Info artist - Display info about a certain artist, by id", "Add Artist - Adds a new artist to storage and assign an artist id. e.g. add artist john osborne", "Add Track - Add a new track to storage. add track watching the sky turn green by jo", "Play Track - Record that an existing track was played at the current time, e.g. play track 13.", "Count tracks - Display how many tracks are known by a certain artist, e.g. count tracks by jo","List tracks - Display the tracks played by a certain artist, e.g. list tracks by jo"]
    end


    def play(input)
        input_ls = input.split(/\s+/)
        id = input_ls[2].to_i
        track = @trackDB.transaction { @trackDB.fetch(id, nil) }
        if(track == nil) 
            return "wrong id number"
         end 
         @queue << [id, Time.now]
         return "now track #{id} is playing"
    end

    def help
        return @help_txt
    end

    def ls_tracks(input)
        input_ls = input.split(/\s+/)
        artist_id = input_ls[2]
        artist = @artist_db.transaction { @artist_db.fetch(artist_id, nil) }
        if(artist == nil) 
            puts "wrong id number"
            return
         end 
         track_list = artist.get_track
         puts "tracks of artist #{artist_id} are: \n"
         track_list.each {|track| puts "#{track.id} #{track.name}"}
    end
    
    def add_track(input)
        input_ls = input.split(/\s+/)
        if(input_ls.size < 5 )
            return "wrong input"
        end
        artist_id = input_ls[-1]
        track_name = input_ls[2...-2].join(" ")
        artist = @artist_db.transaction { @artist_db.fetch(artist_id, nil) }
        if artist == nil
            return "artist not exist, please add artist first"
             
        end
        track_num = @trackDB.transaction { @trackDB.fetch("track_num", 0)}
        track = Track.new(track_name,track_num + 1, artist)
        @trackDB.transaction {@trackDB["track_num"] =  track_num + 1}
        @trackDB.transaction {@trackDB[track_num + 1] = track}
        artist.add_track(track)
        @artist_db.transaction {@artist_db[artist_id] =  artist}

        return "Track add success, track id is #{track_num + 1}"
    end
    
    
    def info_artist(input)
        input_ls = input.split(/\s+/)
        artist_id = input_ls[2]
        artist = @artist_db.transaction { @artist_db.fetch(artist_id, nil) }
        if(artist == nil) 
            puts "wrong id number"
            return
         end 
         puts artist.get_info
    end
    
    def add_artist(input)
        input_ls = input.split(/\s+/)
        if(input_ls.size < 4 )
            puts "wrong artist name"
        end
        name = input_ls[2..-1].join(" ")
        artist_id = input_ls[2..-1].map {|i| i[0]}.join
        artist = @artist_db.transaction { @artist_db.fetch(artist_id, nil) }
        if artist != nil
            if name == artist.name
                puts "artist already exists"
                return
            else
                temp_artist_id = artist_id
                while artist != nil
                    temp_artist_id = artist_id + rand(2**64).to_s
                    artist = @artist_db.transaction { @artist_db.fetch(temp_artist_id, nil) }
                end
                artist_id = temp_artist_id
            end
        end
        artist = Artist.new(name, artist_id)
        @artist_db.transaction do
            @artist_db[artist_id] = artist
            num = @artist_db.fetch("artist_num", 0)
            @artist_db["artist_num"] = num + 1
            @artist_db.commit
        end
        puts "Artist add success, artist id is #{artist_id}"
    end
    
    def count_artists
        artist_num = @artist_db.transaction { @artist_db.fetch("artist_num", 0)}
        return artist_num
    end
    
    def info_track(input)
        input_ls = input.split(/\s+/)
        track_id = input_ls[2].to_i
        track = @trackDB.transaction { @trackDB.fetch(track_id, nil) }
        if(track == nil) 
            puts "wrong id number"
            return
         end 
         puts track.get_info
    end
    
    def exit_ims
        @play_list.transaction do
            @play_list["queue"] = @queue
        @play_list.commit
        end
        return "bye"
    end

    def info
        info = "Last played 3 tracks are: \n"
        info += @queue[0..2].inspect
        info += "\nnumber of tracks are #{count_tracks(0)}"
        info += "\nnumber of artists are #{count_artists}"
        return info
    end
    
    def count_tracks(input)
        if input == 0
            track_num = @trackDB.transaction { @trackDB.fetch("track_num", 0)}
            return track_num
        else
            input_ls = input.split(/\s+/)
            artist_id = input_ls[2]
            artist = @artist_db.transaction { @artist_db.fetch(artist_id, nil) }
            if(artist == nil) 
                return "wrong id number"
                return
             end 
             return "artist #{artist_id} has #{artist.count_tracks} tracks"
        end
    
    end
    
end
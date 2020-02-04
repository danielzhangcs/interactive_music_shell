class Artist
    attr_accessor :name, :id
    def initialize(name,id)
      @name = name
      @id = id
      @track_list = Array.new
    end

    def add_track(new_track)
        @track_list << new_track
    end

    def get_track
        return @track_list
    end

    def count_tracks
        return @track_list.size
    end

    def get_name 
        return @name
    end

    def get_info
        return "Player #{@name}'s id is #{@id}"
    end 

end

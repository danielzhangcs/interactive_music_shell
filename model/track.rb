class Track
    attr_accessor :id, :name, :player
    def initialize(name, id, player)
      @name = name
      @id = id
      @player = player
    end

    def get_info
        return "number #{@id} is track named #{@name}, player is #{@player.get_name}."
    end

    def self.to_s
        return @name
    end

end
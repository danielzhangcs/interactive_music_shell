require_relative './Shell.rb'

class Starter
    def initialize
      @shell = Shell.new
    end

    def start
        prompt = "ims>"
        while true
            print ">"
            input = gets.chomp.strip.downcase
            handle_cmd(input)
            if input == "exit"
                break
            end
        end
    end

    def handle_cmd(input)
        if input == "help"  then puts @shell.help
        elsif input == "info" then  puts @shell.info
        elsif input ==  "exit" then puts @shell.exit_ims
        elsif input.split(" ").size < 3 then puts "wrong input"
        elsif input.start_with?("info track") then @shell.info_track(input)
        elsif input.start_with?("info artist") then @shell.info_artist(input)
        elsif input.start_with?("add artist") then @shell.add_artist(input)
        elsif input.start_with?("add track") then puts @shell.add_track(input)
        elsif input.start_with?("list tracks") then @shell.ls_tracks(input)
        elsif input.start_with?("play track") then puts @shell.play(input)
        elsif input.start_with?("count tracks") then puts @shell.count_tracks(input)
        else puts "wrong input"
         end

    end


    

end
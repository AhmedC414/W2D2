require_relative "room"

class Hotel
    
    def initialize (name, hash)
        @name = name
        @rooms = {}

        hash.each do |room, cap|
            @rooms[room] = Room.new(cap)
        end
    end

    def name
        @name.split.map { |word| word.capitalize }.join(" ")
    end

    def rooms
        @rooms
    end

    def room_exists?(room_name)
        return true if @rooms.has_key?(room_name)
        false
    end

    def check_in(person, room_name)
        if !self.room_exists?(room_name)
            print "sorry, room does not exist"
        else 
            if @rooms[room_name].add_occupant(person)
                print "check in successful"
            else
                 print "sorry, room is full"
            end
        end
    end

    def has_vacancy?
        @rooms.each do |room, cap|
            if !@rooms[room].full?
                return true
            end
        end
        false
    end

    def list_rooms
        @rooms.each do |room, cap|
            puts room + " : " + @rooms[room].available_space.to_s
        end
    end
end

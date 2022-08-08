class Grid
    attr_accessor :grid_height, :grid_width, :grid

    def initialize(data)
        @grid_height = data.size
        @grid_width = data[0].size
        @grid = make_grid(data)
        print_grid()
        next_iteration()
    end

    def print_grid()
        @grid_height.times do |i|
            @grid_width.times do |j|
                if @grid[i][j].alive === 0
                    print '.'
                else
                    print '*'
                end
            end
            puts ''
        end
    end

    def make_grid(data)
        array = Array.new(@grid_height) { Array.new(@grid_width) { Cell.new } }
        @grid_height.times do |i|
            @grid_width.times do |j|
                if data[i][j] === '*'
                    array[i][j].revive_cell()
                else
                    array[i][j].kill_cell()
                end
            end
        end
        return array
    end

    def next_iteration()
        
    end
end

class Cell
    attr_accessor :alive

    def initialize()
        @alive = 0
    end

    def kill_cell()
        @alive = 0
    end

    def revive_cell()
        @alive = 1
    end
end


def openFile(ruta)
    file = File.open(ruta)
    file_data = file.readlines.map(&:chomp)
    return file_data
end


data = openFile('text.text')
grid = Grid.new(data)

class Grid
  attr_accessor :grid_height, :grid_width, :grid

  def initialize(data)
    @grid_height = data.size
    @grid_width = data[0].size
    @grid = make_grid(data)
    check_neighbors
    print_grid
  end

  def print_grid
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
        array[i][j].pos_x = j
        array[i][j].pos_y = i
        if data[i][j] === '*'
          array[i][j].revive_cell
        else
          array[i][j].kill_cell
        end
      end
    end
    array
  end

  def check_neighbors
    @grid.each do |row|
      row.each do |cell|
        neighbors = []
        cell_position_y = cell.pos_y
        cell_position_x = cell.pos_x
        # NORTH
        neighbors << @grid[cell_position_y - 1][cell_position_x] if cell_position_y - 1 >= 0
        # NORTH-EAST
        if cell_position_y - 1 >= 0 && cell_position_x + 1 < @grid_width
          neighbors << @grid[cell_position_y - 1][cell_position_x + 1]
        end
        # EAST
        neighbors << @grid[cell_position_y][cell_position_x + 1] if cell_position_x + 1 < @grid_width
        # SOUTH-EAST
        if cell_position_y + 1 < @grid_height && cell_position_x + 1 < @grid_width
          neighbors << @grid[cell_position_y + 1][cell_position_x + 1]
        end
        # SOUTH
        neighbors << @grid[cell_position_y + 1][cell_position_x] if cell_position_y + 1 < @grid_height
        # SOUTH-WEST
        if cell_position_y + 1 < @grid_height && (cell_position_x - 1) >= 0
          neighbors << @grid[cell_position_y + 1][cell_position_x - 1]
        end
        # WEST
        neighbors << @grid[cell_position_y][cell_position_x - 1] if cell_position_x - 1 >= 0
        # NORTH-WEST
        if (cell_position_y - 1) >= 0 && (cell_position_x - 1) >= 0
          neighbors << @grid[cell_position_y - 1][cell_position_x - 1]
        end

        cell.neighbors = neighbors
      end
    end
  end
end

class Cell
  attr_accessor :alive, :pos_x, :pos_y, :neighbors

  def initialize
    @alive = 0
    @pos_x = 0
    @pos_y = 0
    @neighbors = []
  end

  def kill_cell
    @alive = 0
  end

  def revive_cell
    @alive = 1
  end
end

def openFile(ruta)
  file = File.open(ruta)
  file.readlines.map(&:chomp)
end

data = openFile('text.text')
grid = Grid.new(data)

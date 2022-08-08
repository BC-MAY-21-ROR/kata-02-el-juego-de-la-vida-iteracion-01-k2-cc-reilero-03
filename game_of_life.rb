class Grid
    def initialize(data)
       loopData(data)
    end

    def loopData(data)
        for cell in data do
            puts cell
        end 
    end
end

class Cell
    
end


def openFile(ruta)
    file = File.open(ruta)
    file_data = file.readlines.map(&:chomp)
    heigth = file_data.size
    width = file_data[0].size
    return file_data
end


data = openFile('text.text')
grid = Grid.new(data)

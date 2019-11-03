class Knight
  attr_accessor :pos, :last_move, :moves
  def initialize(pos, last_move=nil)
    @pos = pos
    @last_move = last_move
    # Place moves if they exist on the board, otherwise return a nil value in the array.
    @moves = [
      if pos[0] >= 2 && pos[0] < 8 && pos[1] >= 0 && pos[1] < 7; [pos[0] - 2, pos[1] + 1] end, 
      if pos[0] >= 1 && pos[0] < 8 && pos[1] >= 0 && pos[1] < 6; [pos[0] - 1, pos[1] + 2] end,
      if pos[0] >= 0 && pos[0] < 7 && pos[1] >= 0 && pos[1] < 6; [pos[0] + 1, pos[1] + 2] end,
      if pos[0] >= 0 && pos[0] < 6 && pos[1] >= 0 && pos[1] < 7; [pos[0] + 2, pos[1] + 1] end,
      if pos[0] >= 0 && pos[0] < 6 && pos[1] >= 1 && pos[1] < 8; [pos[0] + 2, pos[1] - 1] end,
      if pos[0] >= 0 && pos[0] < 7 && pos[1] >= 2 && pos[1] < 8; [pos[0] + 1, pos[1] - 2] end,
      if pos[0] >= 1 && pos[0] < 8 && pos[1] >= 2 && pos[1] < 8; [pos[0] - 1, pos[1] - 2] end,
      if pos[0] >= 2 && pos[0] < 8 && pos[1] >= 1 && pos[1] < 8; [pos[0] - 2, pos[1] - 1] end
  ]
  end
end

class Board
  attr_accessor :squares, :root, :target, :x, :y, :move
  def initialize(coords, target)
    @target = target
    @x = coords[0]
    @y = coords[1]
    @squares = []
    8.times do |x|
      @squares << []
      8.times do |y|
        @squares[x] << 0
      end
    end
    @root = Knight.new(coords)
    # [y][x] seems easier to visualize in this exercise   
    @squares[y][x] = "O"
    target_node = find_node(target)
    to_s(target_node)
  end

  def to_s(node)
    output = ""
    puts "You made it in #{move} moves! Heres your path: \n\n"
    while(!node.last_move.nil?)
      output << "#{node.pos.join}\n"
      node = node.last_move
    end
    output << "#{node.pos.join}\n"
    output.reverse!
    output.split do |i|
      puts "[#{i[1]},#{i[0]}]"
    end
  end

  def find_node(target)
    q = []
    return if root.nil? || target.nil?
    q << root
    while(q.any?)
      current = q.shift
      current.moves.compact!
      current.moves.each do |e|
        node = generate(current, e)
        return node if node.pos == target
        q << node
      end
    end
  end

  def generate(c, i)
    @move = 0
    @x = i[0]
    @y = i[1]
    node = Knight.new(i, c)
    i = node
    while(!node.last_move.nil?)
      @move = move + 1
      node = node.last_move
    end
    @squares[y][x] = move
    # Visualize each move as they are made... just dont go from one corner to another...
    # puts "--------------------------------"
    # squares.each do |row|
    #   output = ""
    #   row.each do |tile|
    #     output << "| #{tile} " if tile != squares[y][x]
    #     output << "| \e[33m#{tile}\e[0m " if tile == squares[y][x]
    #   end
    #   puts output
    # end
    # puts "--------------------------------"
    # gets.chomp
    i
  end
end

def knight_moves(start, target)
  Board.new(start, target)
end
# Output is different from TOP example but still same amount of moves either way
knight_moves([3,3], [4,3])
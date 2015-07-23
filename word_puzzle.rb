require 'prawn'

class Puzzle

  def initialize
    @words = []
    @grid = Array.new(45) {Array.new(45,"*")}
    @answer_key = ""
    @alphabet = ["a", "b", "c", "d", "e", "f",
                  "g", "h", "i", "j", "k", "l",
                  "m", "n", "o", "p", "q", "r",
                  "s", "t", "u", "v", "w", "x",
                  "y", "z"]

    @directions = [[0,1],[1,1],[-1,1],[1,0],[0,-1],[1,-1],[-1,-1],[-1,0]]

    #North = [-1,0] #NE = [-1,1] #NW = [-1,1]
    #East = [0,1]
    #South = [1,0] #SE = [1,1]

  end

  def puzzle
    maze_file = File.open("words.txt", "r")
    while !maze_file.eof?
      @words << maze_file.gets.chomp.delete(' ').upcase
    end
    @words.sort_by!{|str| str.length}.reverse!
    maze_file.close
    @words.each do |word|
      place_word word
    end
    @answer_key = ""
    puts @answer_key = print_double


    puts @answer_key.inspect

  end

  def add_random_letters
    @alphabet.each do |word|
      puts word
      id
      puts @grid[0].inspect
    end

    # If char not in letters add to letters
    #
    # After letters is filled
    #
    # Loop rows
    #
    # Loop columns
    #
    # If grid at row column is asterisk
    #
    # Set it to a random pick from letters
  end



  def print_double
    ret_str = ''
    @grid.each do |row|
      ret_str += row.join( " " ) + "\n"
    end
    ret_str += "\n"
    return ret_str
  end

  #TODO: Make sure you use print_double method in the end

  def word_search_board
    @grid.each do |r|
      puts r.map { |p| p }.join(" ")
    end
  end

  def check_word( row, col, word, direction )
    result = false
    word.each_char do |letter|
      result = @grid[row][col] == "*" || @grid[row][col] == letter
      if !result
        break
      end
      row += direction[0]
      col += direction[1]
      if out_of_bounds? row, col
        result = false
        break
      end
    end
    result
  end

  def out_of_bounds?( row, col )
    row < 0 || row > 44 || col < 0 || col > 44
  end

  def add_letters_to_board(row, col, word, direction)
    word.each_char do |letter|
      @grid[row][col] = letter
      row += direction[0]
      col += direction[1]
    end
  end

  def place_word( word )
    #usedLocation = Array.new(@grid.length ) { Array.new(@grid.length,false) }
    placed = false
    while !placed
      row = (rand 0..@grid.length-1)
      col = (rand 0..@grid.length-1)
      # if usedLocation[row][col]
      #   next
      # end
      # usedLocation[row][col] = true
      directions = @directions.shuffle
      directions.each do |direction|
        if check_word(row, col, word, direction)
          add_letters_to_board(row, col, word, direction)
          placed = true
          break
        end
      end

    #   while true
    #     is_it_empty = check_word(row, col, word, direction)
    #     if
    #   end

    end
  end




  def test_add_letters_to_board
    add_letters_to_board((rand 0..@words.length), rand(0..@words.length), @words[0], [0,1])
  end

  def test_check_word
    print check_word((rand 0..@grid.length-1), rand(0..@grid.length-1), @words[0], [0,1])
  end

  def test_place_word
    place_word(@words[0])
  end
end

new = Puzzle.new()
new.puzzle
puts new.print_double
puts new.add_random_letters

#TODO: Don't need word search board
# new.word_search_board



#new.test_add_letters_to_board
#new.word_search_board
#print "\n"
#new.test_check_word
#print "\n"

# new.test_place_word
# print "placed word\n"

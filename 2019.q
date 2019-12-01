d:"I"$read0 `:adventofcode/d1.txt
p1:sum -[;2]div[;3] d
p2:sum {sum 1 _ {0|-[;2]div[;3]x} scan x} d

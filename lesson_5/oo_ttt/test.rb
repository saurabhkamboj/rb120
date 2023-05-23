def display_board
  line_type_one = "     |     |\n"
  line_type_two = "-----|-----|-----\n"

  puts ""
  puts line_type_one * 3
  puts line_type_two
  puts line_type_one * 3
  puts line_type_two
  puts line_type_one * 3
end

display_board

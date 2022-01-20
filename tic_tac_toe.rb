def make_board(a)
  top_row = " #{a} | #{a} | #{a} "
  mid_row = " #{a} | #{a} | #{a} "
  bot_row = " #{a} | #{a} | #{a} "
  spacer_row = '---+---+---'
  puts top_row
  puts spacer_row
  puts mid_row
  puts spacer_row
  puts bot_row
end
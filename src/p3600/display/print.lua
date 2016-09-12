return function(line, column, text)
  love.graphics.print(text, column * 8, line * 8)
end

return function()
  p3600.display.buffer = p3600._dialog_buffer
  p3600._dialog_buffer = nil
  p3600.display.changed = true
end

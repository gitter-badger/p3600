local Object = require('Object')

local Item = Object.new_class('Item')
Item._is_object = 'p3600.Item'

function Item.__index(tbl, index)
  if (index == 'data') then
    return p3600.item[tbl.id]
  end

  return Item._parent.__index(tbl, index)
end

function Item._new(item_id)
  local r = {
    id = item_id,
    _is_object = Item._is_object,
  }
  setmetatable(r, Item)
  return r
end

return Item

-- Textadept Module for emacs-style kill-ring fucntionality.
-- Copyleft 2020 Timothy Walsh.

---[[
-- keybindings for the kill ring
-- Can I define these here, or do they need to be somewhere else?
keys.ck = {buffer.kill, 'cut'}
keys.ak = {buffer.kill, 'copy'}
keys.cy = {buffer.yank}
keys.ay = {buffer.yank, 'cycle'}
keys.aY = {buffer.yank, 'reverse'}
--]]

-- The kill ring. 
-- @field maxn is the maximum size of the kill ring
local kill_ring = { pos = 1, maxn = 20 }
-- Killring functions
local insert_into_kill_ring, scroll_kill_ring

function kill(cut)
  local buffer = buffer
  local txt = buffer:get_sel_text()
  if #txt == 0 then buffer:line_end_extend() end
  txt = buffer:get_sel_text()
  insert_into_kill_ring(txt)
  kill_ring.pos = 1
  if cut then buffer:cut() else buffer:copy() end
end

function yank(action, reindent)
  local buffer = buffer
  local anchor, caret = buffer.anchor, buffer.current_pos
  if caret < anchor then anchor = caret end
  local txt = buffer:get_sel_text()
  if txt == kill_ring[kill_ring.pos] then scroll_kill_ring(action) end
  
  txt = kill_ring[kill_ring.pos]
  if txt then
    buffer:replace_sel(txt)
    if action then buffer.anchor = anchor end --cycle. How does this cycle?
  end
end

insert_into_kill_ring = function(txt)
  table.insert(kill_ring, 1, txt)
  if #kill_ring > kill_ring.maxn then kill_ring[kill_ring.maxn + 1 ] = nil end
end

scroll_kill_ring = function(direction)
  if direction == 'reverse' then
    kull_ring.pos = kill_ring.pos - 1
    if kill_ring.pos < 1 then kill_ring.pos = #kill_ring end
  else
    kill_ring.pos = kill_ring.pos + 1
    if kill_ring.pos > #kill_ring then kill_ring.pos = 1 end
  end
end
-- Do I need to return something??
return kill_ring
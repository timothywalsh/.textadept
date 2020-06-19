-- Textadept Module for emacs-style kill-ring fucntionality.
-- Copyleft 2020 Timothy Walsh.
emacs_style_kill_ring = {}

-- The kill ring. 
-- @field maxn is the maximum size of the kill rking
local kill_ring = { pos = 1, maxn = 20 }
-- emacs_style_kill_ring functions
local insert_into_kill_ring, scroll_kill_ring

function emacs_style_kill_ring.kill(cut)
  local buffer = buffer
  local txt = buffer:get_sel_text()
  if #txt == 0 then buffer:line_end_extend() end
  txt = buffer:get_sel_text()
  insert_into_kill_ring(txt)
  kill_ring.pos = 1
  if cut then buffer:cut() else buffer:copy() end
end

function emacs_style_kill_ring.yank(action, reindent)
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

---[[
-- keybindings for the kill ring
-- Can I define these here, or do they need to be somewhere else?
keys.ck = {kill_ring.kill, 'cut'}
keys.ak = {kill_ring.kill, 'copy'}
keys.cy = {kill_ring.yank}
keys.ay = {kill_ring.yank, 'cycle'}
keys.aY = {kill_ring.yank, 'reverse'}
--]]

return emacs_style_kill_ring
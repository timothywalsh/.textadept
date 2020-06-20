-- Textadept Module for emacs-style kill ring fucntionality.
-- Copyleft 2020 Timothy Walsh.
emacs_style_kill_ring = {}

-- The kill ring. 
-- @field maxn is the maximum size of the kill rking
local kill_ring = { pos = 1, maxn = 20 }
-- emacs_style_kill_ring functions
local insert_into_kill_ring, scroll_kill_ring

---[[
function emacs_style_kill_ring.kill_cut()
  local buffer = buffer
  local txt, pos = buffer:get_cur_line()
  -- if the caret position is at the beginning of a line, then kill the whole line, including newline character(s) at the end
  if pos == 0 then --position is beginning of line 
    buffer:line_cut() --cuts the entire current line to the clipboard
    local txt = ui.clipboard_text
    insert_into_kill_ring(txt)
    kill_ring.pos = 1
  else
    local txt = buffer:get_sel_text()
    if #txt == 0 then buffer:line_end_extend() end
    txt = buffer:get_sel_text()
    insert_into_kill_ring(txt)
    kill_ring.pos = 1
    buffer:cut()
  end
end
--]]

-- Notes: I could use buffer.line_cut() and buffer.line_copy() and just make killing and yanking applicable to whole lines
-- Note: there is also buffer.paste() function. Also textadept.editing.paste_reindent()
-- Maybe can use these functions if killing from the beginning of a line...?
-- I need to check their functionality first

---[[
function emacs_style_kill_ring.kill_copy()
  local buffer = buffer
  local txt = buffer:get_sel_text()
  if #txt == 0 then 
	buffer:line_end_extend() 
	buffer:char_right_extend() -- need to extend to include newline character(s) as well 
  end 
  txt = buffer:get_sel_text()
  insert_into_kill_ring(txt)
  kill_ring.pos = 1
  buffer:copy()
end
--]]

function emacs_style_kill_ring.yank()
  local buffer = buffer
  local anchor, caret = buffer.anchor, buffer.current_pos
  if caret < anchor then anchor = caret end
  local txt = buffer:get_sel_text()
  if txt == kill_ring[kill_ring.pos] then scroll_kill_ring(action) end -- what is this line doing??
  
  txt = kill_ring[kill_ring.pos]
  if txt then
    buffer:replace_sel(txt)
  end
end

function emacs_style_kill_ring.yank_cycle()
  scroll_kill_ring('forward')
  emacs_style_kill_ring.yank()
end

function emacs_style_kill_ring.yank_cycle_reverse()
 scroll_kill_ring('reverse')
 emacs_style_kill_ring.yank()
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

return emacs_style_kill_ring
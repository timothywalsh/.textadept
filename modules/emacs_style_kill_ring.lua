-- Textadept Module for emacs-style kill ring fucntionality.
-- Copyleft 2020 Timothy Walsh.

emacs_style_kill_ring = {}

-- The kill ring. @field maxn is the maximum size of the kill ring
local kill_ring = { pos = 1, maxn = 20 }
-- emacs_style_kill_ring functions
local insert_into_kill_ring

---[[
function emacs_style_kill_ring.kill(mode) -- mode is either cut or copy
  local buffer = buffer
  local _, pos = buffer:get_cur_line() -- I don't need the text that is returned as the first parameter here, so assign it to dummy variable _
  -- if the caret position is at the beginning of a line, then kill the whole line, including newline character(s) at the end
  if pos == 0 then --position is beginning of line 
    if mode == 'cut' then
      buffer:line_cut() --cuts the entire current line to the clipboard
    elseif mode == 'copy' then
      buffer:line_copy() --copies the entire current line to the clipboard
    end
    local txt = ui.clipboard_text
    insert_into_kill_ring(txt)
    kill_ring.pos = 1
  else -- We are somewhere else on the line than the beginning. Kill to the end of the line, not including newline character(s)
    local txt = buffer:get_sel_text() -- If text is selected then kill the selected text
    if #txt == 0 then buffer:line_end_extend() end -- else, extend the selection from the current position to the end of line
    txt = buffer:get_sel_text()
    insert_into_kill_ring(txt)
    kill_ring.pos = 1
    if mode == 'cut' then
      buffer:cut()
    elseif mode == 'copy' then
      buffer:copy()
    end
  end
end

insert_into_kill_ring = function(txt)
  table.insert(kill_ring, 1, txt)
  --if #kill_ring > kill_ring.maxn then kill_ring[kill_ring.maxn + 1 ] = nil end
end
--]]

-- TODO: If two or more lines are killed in succession, then they should be treated as a single kill
-- Note: there is also buffer.paste() function. Also textadept.editing.paste_reindent()

function emacs_style_kill_ring.yank(cycle) -- cycle_direction is either nil, forward or backward
  local buffer = buffer
  --local anchor, caret = buffer.anchor, buffer.current_pos
  local original_position = buffer.current_pos
  --if caret < anchor then anchor = caret end
  txt = kill_ring[kill_ring.pos] -- should I make txt local?
  if cycle == nil then
    --buffer:replace_sel(txt)
    --put the first item of the kill ring onto the clipboard
    buffer:copy_text(txt) -- copies txt to the clipboard
    buffer:paste() -- pastes the contents of the clipboard
    local original_position = original_position
    local new_position = buffer.current_pos
    buffer:set_sel(new_position, original_position)
  elseif cycle == 'forward' then
    kill_ring.pos = kill_ring.pos + 1
    if kill_ring.pos > #kill_ring then kill_ring.pos = 1 end
    emacs_style_kill_ring.yank()
  elseif cycle == 'reverse' then
    kill_ring.pos = kill_ring.pos - 1
    if kill_ring.pos < 1 then kill_ring.pos = #kill_ring end
    emacs_style_kill_ring.yank()
  end
end

--Issues
-- I can only yank once. why???w why???hy???why???why???
--aaaaaaaaaaaaaa
--bbbbbbbbbbbaaaaaaaawhy???
--cccccccccccccccccc  cccccccccccwwhy???hy???why???ccccc
--ddddddddddddddddddwhy???

return emacs_style_kill_ring
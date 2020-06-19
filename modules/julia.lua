--Julia language module for Textadept
--Copyleft 2020 Timothy Walsh

--set tab to 4 spaces

events.connect(events.LEXER_LOADED, function(lexer)
  if lexer ~= 'julia' then return end
  buffer.tab_width = 4
  buffer.use_tabs = false
  view.view_ws = view.WS_VISIBLEALWAYS
end)
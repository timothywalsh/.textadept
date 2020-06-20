
---- theme
if not CURSES then
	buffer:set_theme("base16-timbot-woodland", {
	--buffer:set_theme("base16-woodland", {
		--font = "Inconsolata",
		--font = "Anonymous Pro Regular", 
		fontsize = 16
	})
end

-- Wrap long lines
buffer.wrap_mode = buffer.WRAP_WHITESPACE

-- Hide the horizontal scroll bar
buffer.h_scroll_bar = false

-- Recognize .jl files as Julia code.
textadept.file_types.extensions.jl = 'julia'

-- Display buffers in the order of last viewed first
keys.cb = function() ui.switch_buffer(true) end

--TODO Make control tab cycle buffers in z order also

-- Implement emacs-style kill ring
emacs_style_kill_ring = require('emacs_style_kill_ring')
keys.ck = function() emacs_style_kill_ring.kill_cut() end
keys.ak = function() emacs_style_kill_ring.kill_copy() end
keys.cy = function() emacs_style_kill_ring.yank() end
keys.ay = function() emacs_style_kill_ring.yank_cycle() end
keys.aY = function() emacs_style_kill_ring.yank_cycle_reverse() end
keys.ca = function() buffer.home() end

-- TODO. Implelent TeX-style unicode character insert

-- TODO. Draw a feint line at column 80

-- TODO. Keep caret in the middle third of buffer, vertically 
-- i.e. show context above and below the region being edited
-- I don't know how to do that in a nice way that doesnt also cause weird jumping

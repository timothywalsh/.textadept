
---- theme
if not CURSES then
	buffer:set_theme("base16-woodland", {
		--font = "Inconsolata",
		--font = "Anonymous Pro Regular", 
		fontsize = 16
	})
end

-- Recognize .jl files as Julia code.
textadept.file_types.extensions.jl = 'julia'

--display buffers in the order of last viewed first
keys.cb = function() ui.switch_buffer(true) end

--TODO implement emacs-style kill ring

--TODO implelent TeX-style unicode character insert

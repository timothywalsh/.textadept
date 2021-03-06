-- Base16 Theme: Atelier Dune
-- http://chriskempson.com/projects/base16/
-- Theme author: Bram de Haan (http://atelierbramdehaan.nl)
-- Template Repository: https://github.com/rgieseke/base16-textadept
-- Template adapted from Textadept's default templates
-- Copyright 2007-2020 Mitchell mitchell.att.foicica.com. MIT licensed.

local buffer = buffer
local property, property_int = buffer.property, buffer.property_int

-- Base16 colors
property['color.base00'] = 0x1d2020
property['color.base01'] = 0x242829
property['color.base02'] = 0x5e6b6e
property['color.base03'] = 0x687a7d
property['color.base04'] = 0x809599
property['color.base05'] = 0x8ca2a6
property['color.base06'] = 0xcfe4e8
property['color.base07'] = 0xecfbfe
property['color.base08'] = 0x3737d7
property['color.base09'] = 0x1156b6
property['color.base0A'] = 0x1395ae
property['color.base0B'] = 0x39ac60
property['color.base0C'] = 0x83ad1f
property['color.base0D'] = 0xe18466
property['color.base0E'] = 0xd454b8
property['color.base0F'] = 0x5235d4

-- Default font.
property['font'], property['fontsize'] = 'Bitstream Vera Sans Mono', 10
if WIN32 then
  property['font'] = 'Courier New'
elseif OSX then
  property['font'], property['fontsize'] = 'Monaco', 12
end

-- Predefined styles.
property['style.default'] = 'font:$(font),size:$(fontsize),'..
                            'fore:$(color.base05),back:$(color.base00)'
property['style.linenumber'] = 'fore:$(color.base04),back:$(color.base00)'
--property['style.controlchar'] =
property['style.indentguide'] = 'fore:$(color.base03)'
property['style.calltip'] = 'fore:$(color.base04),back:$(color.base01)'
property['style.folddisplaytext'] = 'fore:$(color.base01)'

-- Token styles.
property['style.class'] = 'fore:$(color.base0A)'
property['style.comment'] = 'fore:$(color.base03)'
property['style.constant'] = 'fore:$(color.base09)'
property['style.embedded'] = 'fore:$(color.base0F),back:$(color.base01)'
property['style.error'] = 'fore:$(color.base08),italics'
property['style.function'] = 'fore:$(color.base0D)'
property['style.identifier'] = ''
property['style.keyword'] = 'fore:$(color.base0E)'
property['style.label'] = 'fore:$(color.base08)'
property['style.number'] = 'fore:$(color.base09)'
property['style.operator'] = 'fore:$(color.base05)'
property['style.preprocessor'] = 'fore:$(color.base0B)'
property['style.regex'] = 'fore:$(color.base0C)'
property['style.string'] = 'fore:$(color.base0B)'
property['style.type'] = 'fore:$(color.base0A)'
property['style.variable'] = 'fore:$(color.base08)'
property['style.whitespace'] = ''

-- Multiple Selection and Virtual Space
--buffer.additional_sel_alpha =
--buffer.additional_sel_fore =
--buffer.additional_sel_back =
--buffer.additional_caret_fore =

-- Caret and Selection Styles.
buffer:set_sel_fore(true, property_int['color.base06'])
buffer:set_sel_back(true, property_int['color.base02'])
--buffer.sel_alpha =
buffer.caret_fore = property_int['color.base05']
buffer.caret_line_back = property_int['color.base01']
--buffer.caret_line_back_alpha =

-- Fold Margin.
buffer:set_fold_margin_colour(true, property_int['color.base00'])
buffer:set_fold_margin_hi_colour(true, property_int['color.base00'])

-- Markers.
local MARK_BOOKMARK = textadept.bookmarks.MARK_BOOKMARK
--buffer.marker_fore[MARK_BOOKMARK] = property_int['color.base00']
buffer.marker_back[MARK_BOOKMARK] = property_int['color.base0B']
--buffer.marker_fore[textadept.run.MARK_WARNING] = property_int['color.base00']
buffer.marker_back[textadept.run.MARK_WARNING] = property_int['color.base0E']
--buffer.marker_fore[textadept.run.MARK_ERROR] = property_int['color.base00']
buffer.marker_back[textadept.run.MARK_ERROR] = property_int['color.base08']
for i = buffer.MARKNUM_FOLDEREND, buffer.MARKNUM_FOLDEROPEN do -- fold margin
  buffer.marker_fore[i] = property_int['color.base00']
  buffer.marker_back[i] = property_int['color.base03']
  buffer.marker_back_selected[i] = property_int['color.base02']
end

-- Indicators.
buffer.indic_fore[ui.find.INDIC_FIND] = property_int['color.base09']
buffer.indic_alpha[ui.find.INDIC_FIND] = 255
local INDIC_BRACEMATCH = textadept.editing.INDIC_BRACEMATCH
buffer.indic_fore[INDIC_BRACEMATCH] = property_int['color.base06']
local INDIC_HIGHLIGHT = textadept.editing.INDIC_HIGHLIGHT
buffer.indic_fore[INDIC_HIGHLIGHT] = property_int['color.base07']
buffer.indic_alpha[INDIC_HIGHLIGHT] = 255
local INDIC_PLACEHOLDER = textadept.snippets.INDIC_PLACEHOLDER
buffer.indic_fore[INDIC_PLACEHOLDER] = property_int['color.base04']

-- Call tips.
buffer.call_tip_fore_hlt = property_int['color.base06']

-- Long Lines.
buffer.edge_colour = property_int['color.base02']

-- Add red, green, and yellow for diff lexer.
property['color.red'] = property['color.base08']
property['color.green'] = property['color.base0B']
property['color.yellow'] = property['color.base0E']

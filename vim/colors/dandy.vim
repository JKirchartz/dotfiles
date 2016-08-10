" Vim color file
"  Maintainer: JKirchartz
"  Based on Candy by Tiza
" Last Change: 2015/10/30 Sun 19:35.
"     version: 1.0
" This color scheme uses a dark background.

set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif

let colors_name = "dandy"

hi Normal guifg=#f0f0f8 guibg=#000000 gui=NONE ctermfg=231 ctermbg=16 cterm=NONE

" Search
hi IncSearch guifg=#80ffff guibg=#0060c0 gui=UNDERLINE ctermfg=123 ctermbg=25 cterm=UNDERLINE
hi Search guifg=#f0f0f8 guibg=#0060c0 gui=NONE ctermfg=231 ctermbg=25 cterm=NONE

" Messages
hi ErrorMsg guifg=#ffa0ff guibg=NONE gui=BOLD ctermfg=219 ctermbg=NONE cterm=BOLD
hi WarningMsg guifg=#ffa0ff guibg=NONE gui=BOLD ctermfg=219 ctermbg=NONE cterm=BOLD
hi ModeMsg guifg=#40f0d0 guibg=NONE gui=BOLD ctermfg=86 ctermbg=NONE cterm=BOLD
hi MoreMsg guifg=#00ffff guibg=#008070 gui=BOLD ctermfg=14 ctermbg=29 cterm=BOLD
hi Question guifg=#e8e800 guibg=NONE gui=BOLD ctermfg=184 ctermbg=NONE cterm=BOLD

" Split area
hi StatusLine guifg=#000000 guibg=#c8c8d8 gui=NONE ctermfg=16 ctermbg=188 cterm=NONE
hi StatusLineNC guifg=#707080 guibg=#c8c8d8 gui=NONE ctermfg=60 ctermbg=188 cterm=NONE
hi VertSplit guifg=#606080 guibg=#c8c8d8 gui=NONE ctermfg=60 ctermbg=188 cterm=NONE
hi Menu guifg=#ffffff guibg=#888888 gui=NONE ctermfg=231 ctermbg=102 cterm=NONE
hi WildMenu guifg=#ffffff guibg=#888888 gui=NONE ctermfg=231 ctermbg=102 cterm=NONE

" Diff
hi DiffText guifg=#ff78f0 guibg=#a02860 gui=NONE ctermfg=213 ctermbg=125 cterm=NONE
hi DiffChange guifg=#e03870 guibg=#601830 gui=NONE ctermfg=167 ctermbg=53 cterm=NONE
hi DiffDelete guifg=#a0d0ff guibg=#0020a0 gui=NONE ctermfg=153 ctermbg=19 cterm=NONE
hi DiffAdd guifg=#a0d0ff guibg=#0020a0 gui=NONE ctermfg=153 ctermbg=19 cterm=NONE

" Cursor
hi Cursor guifg=#00ffff guibg=#008070 gui=NONE ctermfg=14 ctermbg=29 cterm=NONE
hi lCursor guifg=#ffffff guibg=#8800ff gui=NONE ctermfg=231 ctermbg=93 cterm=NONE
hi CursorIM guifg=#ffffff guibg=#8800ff gui=NONE ctermfg=231 ctermbg=93 cterm=NONE

" Fold
hi Folded guifg=#40f0f0 guibg=#005080 gui=NONE ctermfg=87 ctermbg=24 cterm=NONE
hi FoldColumn guifg=#40c0ff guibg=#00305c gui=NONE ctermfg=75 ctermbg=23 cterm=NONE

" Other
hi Directory guifg=#40f0d0 guibg=NONE gui=NONE ctermfg=86 ctermbg=NONE cterm=NONE
hi LineNr guifg=#9090a0 guibg=NONE gui=NONE ctermfg=103 ctermbg=NONE cterm=NONE
hi NonText guifg=#4080ff guibg=NONE gui=BOLD ctermfg=69 ctermbg=NONE cterm=BOLD
hi SpecialKey guifg=#8080ff guibg=NONE gui=BOLD ctermfg=105 ctermbg=NONE cterm=BOLD
hi Title guifg=#f0f0f8 guibg=NONE gui=BOLD ctermfg=231 ctermbg=NONE cterm=BOLD
hi Visual guifg=#e0e0f0 guibg=#707080 gui=NONE ctermfg=189 ctermbg=60 cterm=NONE

" Syntax group
hi Comment guifg=#c0c0d0 guibg=NONE gui=NONE ctermfg=146 ctermbg=NONE cterm=NONE
hi Constant guifg=#90d0ff guibg=NONE gui=NONE ctermfg=117 ctermbg=NONE cterm=NONE
hi Error guifg=#ffffff guibg=#ff0088 gui=BOLD ctermfg=231 ctermbg=198 cterm=BOLD
hi Identifier guifg=#40f0f0 guibg=NONE gui=NONE ctermfg=87 ctermbg=NONE cterm=NONE
hi Ignore guifg=#000000 guibg=NONE gui=NONE ctermfg=16 ctermbg=NONE cterm=NONE
hi PreProc guifg=#40f0a0 guibg=NONE gui=NONE ctermfg=85 ctermbg=NONE cterm=NONE
hi Special guifg=#e0e080 guibg=NONE gui=NONE ctermfg=186 ctermbg=NONE cterm=NONE
hi Statement guifg=#ffa0ff guibg=NONE gui=NONE ctermfg=219 ctermbg=NONE cterm=NONE
hi Todo guifg=#ffa0a0 guibg=NONE gui=BOLD,UNDERLINE ctermfg=217 ctermbg=NONE cterm=BOLD,UNDERLINE
hi Type guifg=#ffc864 guibg=NONE gui=NONE ctermfg=221 ctermbg=NONE cterm=NONE
hi Underlined guifg=#f0f0f8 guibg=NONE gui=UNDERLINE ctermfg=231 ctermbg=NONE cterm=UNDERLINE

" HTML
hi htmlLink guifg=NONE guibg=NONE gui=UNDERLINE ctermfg=NONE ctermbg=NONE cterm=UNDERLINE
hi htmlBold guifg=NONE guibg=NONE gui=BOLD ctermfg=NONE ctermbg=NONE cterm=BOLD
hi htmlBldItalic guifg=NONE guibg=NONE gui=BOLD,ITALIC ctermfg=NONE ctermbg=NONE cterm=BOLD,ITALIC
hi htmlBoldUnderline guifg=NONE guibg=NONE gui=BOLD,UNDERLINE ctermfg=NONE ctermbg=NONE cterm=BOLD,UNDERLINE
hi htmlBoldUnderlineItalic guifg=NONE guibg=NONE gui=BOLD,UNDERLINE,ITALIC ctermfg=NONE ctermbg=NONE cterm=BOLD,UNDERLINE,ITALIC
hi htmlItalic guifg=NONE guibg=NONE gui=ITALIC ctermfg=NONE ctermbg=NONE cterm=ITALIC
hi htmlUnderline guifg=NONE guibg=NONE gui=UNDERLINE ctermfg=NONE ctermbg=NONE cterm=UNDERLINE
hi htmlUnderlineItalic guifg=NONE guibg=NONE gui=UNDERLINE,ITALIC ctermfg=NONE ctermbg=NONE cterm=UNDERLINE,ITALIC

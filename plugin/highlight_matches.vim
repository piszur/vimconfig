
"=====[ Highlight matches when jumping to next ]=============

" this rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.3)<cr>
nnoremap <silent> N   N:call HLNext(0.3)<cr>

"    highlight WhiteOnRed ctermbg=red ctermfg=white cterm=bold
"    function! HLNext (blinktime)
"        let [bufnum, lnum, col, off] = getpos('.')
"        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
"        let target_pat = '\c\%#'.@/
"        let blinks = 3
"        for n in range(1,blinks)
"          let red = matchadd('WhiteOnRed', target_pat, 101)
"          redraw
"          exec 'sleep ' . float2nr(a:blinktime / (2*blinks) * 1000) . 'm'
"          call matchdelete(red)
"          redraw
"          exec 'sleep ' . float2nr(a:blinktime / (2*blinks) * 1000) . 'm'
"        endfor
"    endfunction

   highlight WhiteOnRed ctermbg=red ctermfg=white cterm=bold
   function! HLNext (blinktime)
     let [bufnum, lnum, col, off] = getpos('.')
     let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
     let target_pat = '\c\%#'.@/
     let ring = matchadd('WhiteOnRed', target_pat, 101)
     redraw
     exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
     call matchdelete(ring)
     redraw
   endfunction

" " OR ELSE ring the match in red...
" function! HLNext (blinktime)
"     highlight RedOnRed ctermfg=red ctermbg=red
"     let [bufnum, lnum, col, off] = getpos('.')
"     let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
"     echo matchlen
"     let ring_pat = (lnum > 1 ? '\%'.(lnum-1).'l\%>'.max([col-4,1]) .'v\%<'.(col+matchlen+3).'v.\|' : '')
"             \ . '\%'.lnum.'l\%>'.max([col-4,1]) .'v\%<'.col.'v.'
"             \ . '\|'
"             \ . '\%'.lnum.'l\%>'.max([col+matchlen-1,1]) .'v\%<'.(col+matchlen+3).'v.'
"             \ . '\|'
"             \ . '\%'.(lnum+1).'l\%>'.max([col-4,1]) .'v\%<'.(col+matchlen+3).'v.'
"     let ring = matchadd('RedOnRed', ring_pat, 101)
"     redraw
"     exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
"     call matchdelete(ring)
"     redraw
" endfunction

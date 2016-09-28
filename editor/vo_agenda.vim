augroup AgendaAu
	au!
	au BufReadCmd   agenda://*  call AgendaRead(expand("<amatch>"))
	au FileReadCmd  agenda://*  call AgendaRead(expand("<amatch>"))
	"au BufWriteCmd  agenda://*  call AgendaWrite(expand("<amatch>"))
	"au FileWriteCmd agenda://*  call AgendaWrite(expand("<amatch>"))
	"au BufReadPost   agenda://*  call AgendaBufReadPost()
augroup END
"
" TODO use path to figure this out
let g:outline_agenda_bin = '~/sw_projects/zmughal/otl-parser/otl-parser/bin/dump-outline'
function! AgendaRead(uri)
	let filename = substitute(a:uri, "^agenda://","", "")
	exe "sil! r!".g:outline_agenda_bin." ".filename
	if v:shell_error != 0
		redraw!
		echohl Error | echo "***error*** (AgendaRead) sorry, unable to fetch agenda" | echohl None
	else
		" cleanup
		keepj sil! 0d
		setl nomod
		setf vo_base
		nmap <buffer> ;; zA
	endif
endfunction

command! -bang Agenda exe "new agenda://".expand("%:p")

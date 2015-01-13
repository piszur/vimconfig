"set connection
let t:pga_host = "adatbazis"                     "az adatbázis szerver elérhetősége
let t:pga_user = "root"                          "felhasználó az adatbázis gépen
let t:pga_tunnel_host = "192.168.7.254"          "proxy szerver neve
let t:pga_tunnel_user = "piszur"                 "felhasználó a proxy szerverhez

"set filenames
let t:pga_local_dir = "/tmp/"                    "helyi könyvtár
let t:pga_remote_dir = "/tmp/"                   "mappa az adatabázis szerveren
let t:pga_sql_filename = "vim_pgadmin.sql"       "sql ideiglenes fájl neve
let t:pga_res_filename = "vim_pgadmin_res.log"   "eredményfájl neve
let t:pga_err_filename = "vim_pgadmin_err.log"   "hibafájl neve

"set database
let t:pga_database_name = "fter"                 "adatbázis neve
let t:pga_database_user = "postgres"             "adatbázis felhasználó

"run sql command
function! PgARunSql(mode)

  "vizuális módban a kijelölés, egyébként az egész fájl beírása ideiglenes fájlba
  if a:mode == 'visual'
    :execute 'silent ''<,''> w! '.t:pga_local_dir.'vim_pgadmin.sql'
  else
    :execute 'silent % w! '.t:pga_local_dir.'vim_pgadmin.sql'
  endif

  "ideiglenes fájl átmásolása az adatbázis gépre
  :execute 'silent !cat /tmp/'.t:pga_sql_filename.' | ssh -A '.t:pga_tunnel_user.'@'.t:pga_tunnel_host.' "ssh -A '.t:pga_user.'@'.t:pga_host.' ''cat - >/tmp/'.t:pga_sql_filename.';chmod 664 /tmp/'.t:pga_sql_filename''' "'

  "psql futtatása az adatbázis gépen
  :execute 'silent !ssh -A '.t:pga_tunnel_user.'@'.t:pga_tunnel_host.' "ssh -A '.t:pga_user.'@'.t:pga_host.' ''su -l -s /bin/bash -c \"psql '.t:pga_database_name.' -f /tmp/'.t:pga_sql_filename.' 1>/tmp/'.t:pga_res_filename.' 2>/tmp/'.t:pga_err_filename.' \" '.t:pga_database_user.''' "'

" ssh -A piszur@192.168.7.254 "ssh -A root@adatbazis 'cd /tmp/; tar cf - vim_pagadmin_?.log' " | ( cd /tmp; tar xf - )

  "képernyő újrarajzolása
  :redraw!
endfunction

"ablakok be/kikapcsolása
function! PgAGetStatus()
  " let l:WinList = map(range(1, winnr('$')), '[v:val, bufname(winbufnr(v:val))]')
  let l:WinList = map(range(1, winnr('$')), 'bufname(winbufnr(v:val))')

  let l:HasPga = index(l:WinList,"/tmp/vim_pgadmin.sql")
  echo l:HasPga
  echo l:WinList

endfunction

nnoremap <F5> :call PgARunSql("all")<CR>
vnoremap <F5> <ESC>:call PgARunSql("visual")<CR>

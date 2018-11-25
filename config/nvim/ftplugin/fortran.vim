" Fortran specific spacing:
let fortran_free_source=1
let fortran_have_tabs=1
let fortran_more_precise=1
let fortran_do_enddo=1

" ---------- tabulator / shiftwidth --------------------
"  Set tabulator and shift width to 4 (Fortran Style Guide)
"  Also force spaces, expand tabs
"
setlocal expandtab               " Uses spaces instead of tabs
setlocal softtabstop =4          " Tab key indents by 4 spaces

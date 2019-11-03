
let b:ale_fixers=['black']
let b:ale_fix_on_save=1

call coc#config('python', {
\   'jediEnabled': v:false,
\   'pythonPath': split(execute('!which python'), '\n')[-1]
\ })

set nocompatible              " be improvquired


" Установить при еноюходимости Plug.vim
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" user defined plugins

    " Визуальное оформление
    Plug 'https://github.com/vim-airline/vim-airline.git'
    Plug 'https://github.com/morhetz/gruvbox'

    " Улучшение работы с текстовыми объектами
    Plug 'https://github.com/paradigm/TextObjectify'

    " Возврат к английской раскладке после insert mod'а
    " *Требует xkb-switch TODO
    " Plug 'https://github.com/lyokha/vim-xkbswitch'

    " Автодополнение при интеграции с tmux'ом
    " Plug 'https://github.com/wellle/tmux-complete.vim'

    " Радужные скобки
    Plug 'https://github.com/kien/rainbow_parentheses.vim'

    " Интеграция с git, загружать при открытии соответствующего окна
    Plug 'https://github.com/airblade/vim-gitgutter.git', {
        \ 'on' : 'GitGutterToggle'
    \ }

    " Позволяет открыть выделенный фрагмент в новом окне, отредактировать, а
    " потом снова синхонизировать с остальным текстом
    Plug 'https://github.com/chrisbra/NrrwRgn'

    " Улучшенное поведение .
    Plug 'https://github.com/tpope/vim-repeat'

    " Стартовый экран
    Plug 'https://github.com/mhinz/vim-startify'

    " Работа со скобками и подобными парными сущностями
    Plug 'https://github.com/tpope/vim-surround'

    " Перемещение блоков текста вверх и вниз
    Plug 'https://github.com/matze/vim-move'

    " Поиск последовательностей из двух символов и перемещение между ними
    Plug 'https://github.com/justinmk/vim-sneak'

    " Показывать теги для текущего файла, загружать при открытии
    " соответствующего окна
    Plug 'https://github.com/majutsushi/tagbar.git'

    " Множественное выделение, как в SublimeText
    Plug 'https://github.com/terryma/vim-multiple-cursors.git'

    " Автодополнение, подсказки при вводе, рефакторинг и т.д.для некоторых ЯП
    " Поддержка:
    "   - C-family (pure c, c++, objective c)
    "   - C#
    Plug 'Valloric/YouCompleteMe', {
        \ 'for': ['c', 'cpp', 'cs', 'objc', 'objcpp'],
        \ 'do': 'git submodule update --init --recursive; ./install.py
                \  --clang-completer --omnisharp-completer'
    \ }
    " генерация конфигурационного файла
    Plug 'rdnetto/YCM-Generator', {
        \ 'on' : 'YcmGenerateConfig',
        \ 'branch' : 'stable'
    \ } 

    " Генерация кода
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " Посветка синтаксиса в pure c/c++/objective c
    " Plug 'https://github.com/jeaye/color_coded.git', {
    "     \ 'for' : ['c', 'cpp', 'objc']
    " \ }


    " Удобое комментирование
    Plug 'scrooloose/nerdcommenter'

    " Дерево проекта  + взаимодействе с гитом
    Plug 'scrooloose/nerdtree', {
        \ 'on': 'NERDTreeToggle'
    \ }

    " CommonLisp IDE -- SLIMV
    Plug 'https://github.com/kovisoft/slimv.git', {
        \ 'for': ['lisp','clojure','hy','scheme','racket']
    \ }

" All of your Plugins must be added before the following line

" Initialize plugin system
call plug#end()
filetype plugin indent on    " required

" -----------------------------------------------------------------------------
" Пользовательские типы файлов
" -----------------------------------------------------------------------------

    augroup filetypedetect
        autocmd BufNewFile,BufRead *.tmpl,*.tpl setfiletype html
        autocmd BufNewFile,BufRead *.h,*.c setfiletype c
        autocmd BufNewFile,BufRead *.ino setfiletype cpp
    augroup END

" -----------------------------------------------------------------------------
" Общие настройки 
" -----------------------------------------------------------------------------

    " Показать номера строк
    set number

    " Автоматически обновлять файл при изменении сторонней программой
    set autoread

    " Подсветка синтаксиса
    syntax on

    " Более логичное действие Y, копирование до конца строки
    noremap Y y$

    " Использовать клавиши k и K для перемещения между окнами
    "                                                                  [ k ]
    "                                                                  [ K ]
    nnoremap k <C-W>w 
    nnoremap K <C-W>W 

    " Возможность переопределять настройки для проекта в локальных .vimrc
    set exrc
    
    " Запрет опасных команд в локальных .vimrc
    set secure

    " В режиме выделения повесить функционал плагина vim.surround на клавишу s
    "                                                                   [ s ]
    vmap s S

    " Редактировать выделенный текст в новом окне
    "                                                 [ Leader + Leader + w ]
    vnoremap <leader><leader>w :NR<CR>

    " Не снимать выделение после использования > и <
    vnoremap < <gv
    vnoremap > >gv

    " При редактировании vimrc назначить доп. комбинацию клавиш для сохранения и
    " использования текущей конфигурации редактора
    "                                                 [ Leader + Leader + u ]
    
    autocmd BufNewFile,BufRead vimrc,.vimrc 
        \ noremap <buffer> <leader><leader>u :w<CR>:source $MYVIMRC<CR>

    " Автоматически изменять текущий путь в зависимости от выбраного буфера
    autocmd BufEnter * lcd %:p:h

    " Перемещение/копирование строк/выделнного текста в соседнее окно
    "                                                  [ Ctrl + L + <ARROW> ]
    "                                           [ Ctrl + L + Ctrl + <ARROW> ]
    vnoremap <C-L><UP> y<C-W><UP>P<CR><C-W><DOWN>
    noremap <C-L><UP> yy<C-W><UP>P<CR><C-W><DOWN>
    vnoremap <C-L><C-UP> d<C-W><UP>P<CR><C-W><DOWN>
    noremap <C-L><C-UP> dd<C-W><UP>P<CR><C-W><DOWN>

    vnoremap <C-L><LEFT> y<C-W><LEFT>P<CR><C-W><RIGHT>
    noremap <C-L><LEFT> yy<C-W><LEFT>P<CR><C-W><RIGHT>
    vnoremap <C-L><C-LEFT> d<C-W><LEFT>P<CR><C-W><RIGHT>
    noremap <C-L><C-LEFT> dd<C-W><LEFT>P<CR><C-W><RIGHT>

    vnoremap <C-L><DOWN> y<C-W><DOWN>P<CR><C-W><UP>
    noremap <C-L><DOWN> yy<C-W><DOWN>P<CR><C-W><UP>
    vnoremap <C-L><C-DOWN> d<C-W><DOWN>P<CR><C-W><UP>
    noremap <C-L><C-DOWN> dd<C-W><DOWN>P<CR><C-W><UP>

    vnoremap <C-L><RIGHT> y<C-W><RIGHT>P<CR><C-W><LEFT>
    noremap <C-L><RIGHT> yy<C-W><RIGHT>P<CR><C-W><LEFT>
    vnoremap <C-L><C-RIGHT> d<C-W><RIGHT>P<CR><C-W><LEFT>
    noremap <C-L><C-RIGHT> dd<C-W><RIGHT>P<CR><C-W><LEFT>

" -----------------------------------------------------------------------------
" Пользовательские скрипты
" -----------------------------------------------------------------------------

    " Автоматическое создание include guard'ов
    function! InsIncludeGuard()
        let guard_name = 
            \ "_" . substitute(toupper(expand('%:t')), "\\.", "_", "g") . "_"
        execute "normal! 1GO"
        call setline(".", "#ifndef " . guard_name)
        execute "normal! o"
        call setline(".", "#define " . guard_name)
        execute "normal! Go"
        call setline(".", "#endif // " . guard_name)
        execute "normal! o"
    endfunction

    " Вставка #pragma once в начало файла
    function! InsPragmaOnce()
        execute "normal! 1GO"
        call setline(".", "#pragma once")
        execute "normal! o"
        execute "normal! o"
        execute "normal! O"
    endfunction

    " Автоматически применять InsIncludeGuard к новым хедерам c++ (.h++, .hpp)
    autocmd BufNewFile *.{hpp,h++} call InsPragmaOnce()
    " Автоматически применять InsIncludeGuard к новым хедерам си (.h)
    autocmd BufNewFile *.{h} call InsIncludeGuard()

" -----------------------------------------------------------------------------
" Непечатные символы
" -----------------------------------------------------------------------------

    " Комбинация для скрытия/отображения
    "                                                 [ Leader + leader + l ]
    noremap <leader><leader>l :set list!<CR>:set list?<CR>

    " Внешний вид непечатных символов
    " tab - два символа для отображения табуляции (первый символ и заполнитель)
    " eol - символ для отображения конца строки
    " precedes - индикатор продолжения строки в лево
    " extends - индикатор продолжения строки в право
    set listchars=tab:▸·,eol:¬,precedes:«,extends:»,space:\.

" -----------------------------------------------------------------------------
" Работа с буферами
" -----------------------------------------------------------------------------

    " Комбинации клавишь для переключения между буферами
    "                                                      [ Ctrl + Page Up ]
    "                                                    [ Ctrl + Page Down ]
    noremap <C-PAGEDOWN> :bnext<CR>
    noremap <C-PAGEUP> :bprevious<CR>

" -----------------------------------------------------------------------------
" Настройки шелла
" -----------------------------------------------------------------------------

    " Установим шелл
    set shell=sh
    " Автоподстановка в шелле
    set wildmode=longest:list,full

" -----------------------------------------------------------------------------
" Работа с длинными строками 
" -----------------------------------------------------------------------------

    " Включить перенос(визуальный) по словам, если длина строки слишком велика
    set wrap
    " Запретить 'разрывание' длинных строк
    set nolbr
    " В случае наличия неразорванной длинной строки перемещение курсора вверх и
    " вниз работает более привычно
    nnoremap <DOWN> gj
    nnoremap <UP> gk

    " Ширина строки
    set textwidth=80
    " Для лиспа принимаем ширину окна в 120 символов
    autocmd FileType lisp,clojure,hy,scheme,racket setlocal textwidth=120

" -----------------------------------------------------------------------------
" Настройки буфера обмена, копирования и вставки
" -----------------------------------------------------------------------------

    " Комбинации для копирования и вставки через системный буфер
    "  1. копировать
    "                                                   [ Ctrl + Shift + y  ]
    noremap <C-S-Y> "+y
    "  2. вставить
    "                                                   [ Ctrl + Shift + p  ]
    noremap <C-S-P> "+p
    "  3. вырезать
    "                                                   [ Ctrl + Shift + d  ]
    noremap <C-S-D> "+d

" -----------------------------------------------------------------------------
" Манипуляции со строками
" -----------------------------------------------------------------------------

    " Отключаем стандартные биндиги для плагина Move    
    let g:move_map_keys = 0
    " Настраиваем свои комбинации
    "                                                          [ Ctrl + Up ]
    "                                                        [ Ctrl + 2xUp ]
    "                                                        [ Ctrl + Down ]
    "                                                      [ Ctrl + 2xDown ]
    vmap <C-UP> <Plug>MoveBlockUp
    map <C-UP><C-UP> <Plug>MoveLineUp
    vmap <C-DOWN> <Plug>MoveBlockDown
    map <C-DOWN><C-DOWN> <Plug>MoveLineDown

" -----------------------------------------------------------------------------
" Настройки мыши
" -----------------------------------------------------------------------------

    " Включить мышь
    set mouse=a
    
    " Поиск с помощью мыши
    "                                                         [ Shift + ПКМ ]
    "                                                         [ Shift + ЛКМ ]
    set mousemodel=extend

    " При нажатии средней клавиши мыши вставлять текст позицию указателя мыши,
    " а не курсора
    "                                                                 [ СКМ ]
    noremap <MiddleMouse> <LeftMouse><MiddleMouse>
    noremap! <MiddleMouse> <LeftMouse><MiddleMouse>

" -----------------------------------------------------------------------------
" Отступы и табуляция
" -----------------------------------------------------------------------------
    
    " Ширина символа табуляции в пробелах
    set ts=4
    " Количество пробелов, добавляемых при нажатии <Tab>
    set sts=4
    " По-умолчанию заменять симвлы табуляции соответствующим количеством
    " пробелов
    set et
    " На какое количество символов сдвигают команды > и <
    set sw=4
    " Отключить 'Умные' отступы
    set nosmarttab

    " Специфичные настройки для различных типов файлов
    autocmd FileType php setlocal ts=4 sts=4 sw=4 noet
    autocmd FileType python setlocal ts=4 sts=4 sw=4 et
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noet

    autocmd FileType html setlocal ts=2 sts=2 sw=2 noet
    autocmd FileType xhtml setlocal ts=2 sts=2 sw=2 noet
    autocmd FileType xml setlocal ts=2 sts=2 sw=2 noet
    autocmd FileType css setlocal ts=2 sts=2 sw=2 noet

    autocmd FileType vim setlocal ts=4 sts=4 sw=4 et
    autocmd FileType apache setlocal ts=2 sts=2 sw=2 noet
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 et

    autocmd FileType lisp,clojure,hy,scheme,racket 
        \ setlocal ts=2 sts=2 sw=2 et

    autocmd FileType c,cpp setlocal cin

" -----------------------------------------------------------------------------
" Кодировки и раскладка клавиатуры
" -----------------------------------------------------------------------------

    " Дефолтная кодировка
    set ffs=unix,dos,mac
    set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866 

    " Настраиваем переключение раскладок клавиатуры по C-^
    "   !! Неудобно
    " set keymap=russian-jcukenwin

    " При выходе из режима вставки включать английскую раскладку
    " let g:XkbSwitchEnabled = 1

    " TODO

    " Раскладка по умолчанию - английская
    set iminsert=0

" -----------------------------------------------------------------------------
" Оформление
" -----------------------------------------------------------------------------

    " Установить тёмый фон
    set background=dark

    " Настройка Gruvbox
        " Включить наклонный шрифт
        let g:gruvbox_italic = 1
        " Включить наклонный шрифт
        let g:gruvbox_termcolor = 256
        " Контрастность
        let g:gruvbox_contrast_dark = 'hard'

    colorscheme gruvbox

    " Настройка Airline
        " Выбор темы
        let g:airline_theme='gruvbox'
        " Включаем список табов по-умолчанию
        let g:airline#extensions#tabline#enabled = 1
        " Включаем панели по-умолчанию
        set laststatus=2
        " Включаем улучшенные шрифты
        let g:airline_powerline_fonts = 1
        " всегда показывать tabline
        let g:airline#extensions#tabline#tab_min_count = 0
        " отображать директорию только если открыт еще один файл со сходным именем
        let g:airline#extensions#tabline#formatter = 'unique_tail'
        
" -----------------------------------------------------------------------------
" Поиск
" -----------------------------------------------------------------------------

    " Вообще хз, что это такое
    set noshowmatch

    " По-умолчанию отключить подсветку найденных совпадений
    set nohlsearch
    " Комбинация, позволяющая включать и отключать подсветку
    "                                                 [ Leader + Leader + h ]
    noremap <leader><leader>h :set hlsearch!<CR>:set hlsearch?<CR>
    
    " Курсор перемещается к найденному слову в процессе набора
    set incsearch
    
    " Не игнорировать регистр по-умолчанию
    set noignorecase
    " Комбинация для переключения этого параметра
    "                                                 [ Leader + Leader + i ]
    noremap <leader><leader>i :setlocal ignorecase!<CR>:set ignorecase?<CR>
    " Отключить 'умное' определение регистра
    set nosmartcase
    " В текстовых файлах, а также в в файлах исходного кода для 
    " регистро-независимых языков игнорировать регист
    autocmd FileType txt,html,yaml,apache set ignorecase
    autocmd FileType lisp,clojure,hy,scheme,racket set ignorecase

" -----------------------------------------------------------------------------
" Перемещение по тексту и коду
" -----------------------------------------------------------------------------

    " Улучшенное поведение f, F, t и T
    map f <Plug>Sneak_f
    map F <Plug>Sneak_F
    map t <Plug>Sneak_t
    map T <Plug>Sneak_T

    " Поиск последовательности из 2 симовлов
    "                                                                   [ h ]
    "                                                                   [ H ]
    map h  <Plug>Sneak_s
    map H  <Plug>Sneak_S

    " TODO: реализовать аналогичный функционал для Lisp'а и Python'а
    " Семейство команд GoTo
    "   Перейти к хедеру/ импортируемому файлу
    "                                                      [ Leader + g + i ]
    noremap <buffer> <leader>gi <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>gi :YcmCompleter GoToInclude<CR>

    "   Перейти к объявлению
    "                                                      [ Leader + g + c ]
    noremap <buffer> <leader>gc <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>gc :YcmCompleter GoToDeclaration<CR>
    autocmd FileType cs 
        \ noremap <buffer> <leader>gc :YcmCompleter GoToDeclaration<CR>
    " autocmd FileType python 
    "   \ noremap <buffer> <leader>gc :YcmCompleter GoToDeclaration<CR>

    "   Перейти к определению
    "                                                  [ Leader + g + d ]
    noremap <buffer> <leader>gd <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>gd :YcmCompleter GoToDefinition<CR>
    autocmd FileType cs 
        \ noremap <buffer> <leader>gd :YcmCompleter GoToDefinition<CR>
    " autocmd FileType python 
    "   \ noremap <buffer> <leader>gd :YcmCompleter GoToDefinition<CR>

    "   Автоматически подобрать тип перехода и выполнить его
    "                                                  [ Leader + g + g ]
    noremap <buffer> <leader>gg <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>gg :YcmCompleter GoTo<CR>
    autocmd FileType cs 
        \ noremap <buffer> <leader>gi :YcmCompleter GoTo<CR>
    " autocmd FileType python noremap <buffer> <leader>gi :YcmCompleter GoTo<CR>

    "   Ускоренный аналог предыдущей команы. Не перекомпилирует файл перед
    "   вызовом
    "                                                  [ Leader + g + G ]
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>gG :YcmCompleter GoToImprecise<CR>

" -----------------------------------------------------------------------------
" Рефакторинг
" -----------------------------------------------------------------------------

    " FixIt
    "                                                      [ Leader + r + f ]
    noremap <buffer> <leader>rf <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>rf :YcmCompleter FixIt<CR>
    autocmd FileType cs 
        \ noremap <buffer> <leader>rf :YcmCompleter FixIt<CR>

    " Переименовать сущность под курсором
    "                                                      [ Leader + r + n ]
    noremap <buffer> <leader>rn <NOP>

" -----------------------------------------------------------------------------
" Комментарии и документация
" -----------------------------------------------------------------------------

    " Закомментировать строку или выделенные блок
    "                                                       [ Leader + c + c]
    map <leader>cc <plug>NERDCommenterComment
    " Закомментировать строку или выделенные блок (Sexy Comment)
    "                                                       [ Leader + c + s]
    map <leader>cs <plug>NERDCommenterSexy
    " Раскомментировать строку или выделенные блок
    "                                                       [ Leader + c + u]
    map <leader>cu <plug>NERDCommenterUncomment

    " Получить тип данных сущности под курсором
    "                                                       [ Leader + c + t]
    noremap <buffer> <leader>ct <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>ct :YcmCompleter GetType<CR>
    " Аналогично предыдущему, но не вызывает перекомпиляцию файла
    "                                                       [ Leader + c + T]
    noremap <buffer> <leader>cT <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>cT :YcmCompleter GetTypeImprecise<CR>

    " Получить семантического предка сущности под курсором
    "                                                       [ Leader + c + p]
    noremap <buffer> <leader>cp <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>cp :YcmCompleter GetParent<CR>

    " Получить документацию по сущности под курсором
    "                                                       [ Leader + c + d]
    noremap <buffer> <leader>cd <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>cd :YcmCompleter GetDoc<CR>
    autocmd FileType cs 
        \ noremap <buffer> <leader>cd :YcmCompleter GetDoc<CR>
    " Аналогично предыдущему, но не вызывает перекомпиляцию файла
    "                                                       [ Leader + c + D]
    noremap <buffer> <leader>cD <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>cD :YcmCompleter GetDocImprecise<CR>
    autocmd FileType cs 
        \ noremap <buffer> <leader>cD :YcmCompleter GetDocImprecise<CR>

" -----------------------------------------------------------------------------
" Отладка
" -----------------------------------------------------------------------------

    " TODO

" -----------------------------------------------------------------------------
" Проверка орфографии
" -----------------------------------------------------------------------------

    " TODO

" -----------------------------------------------------------------------------
" Сниппеты(UltiSnips)
" -----------------------------------------------------------------------------

    " UltiSnips
    let g:UltiSnipsExpandTrigger="<C-CR>"
    let g:UltiSnipsListSnippets="<C-TAB>"
    let g:UltiSnipsJumpForwardTrigger="<C-RIGHT>"
    let g:UltiSnipsJumpBackwardTrigger="<C-LEFT>"

" -----------------------------------------------------------------------------
" NerdCommenter
" -----------------------------------------------------------------------------

    " Добавлять пробел перед текстом комментария
    let g:NERDSpaceDelims = 1
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1
    " Align line-wise comment delimiters flush left instead of following code
    " indentation
    let g:NERDDefaultAlign = 'left'
    " Пример использования собственного стиля комментирования
    let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
    " Allow commenting and inverting empty lines (useful when commenting a
    " region)
    let g:NERDCommentEmptyLines = 1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1

" -----------------------------------------------------------------------------
" Дополнительные окна (NerdTree, TagBar, GitGutter)
" -----------------------------------------------------------------------------

    " Показывать панель NerdTree по клавише
    "                                                                 [ F5 ]
    noremap <F5> :NERDTreeToggle<CR> 

    " TagBar
    "                                                                 [ F6 ]
    noremap <F6> :TagbarToggle<CR>

    " GitGutter
    "                                                                 [ F7 ]
    noremap <F7> :GitGutterToggle<CR>

" -----------------------------------------------------------------------------
" SLIMV
" -----------------------------------------------------------------------------

    " Не выставлять закрывающие скобки автоматически
    let g:paredit_mode=0
    " включаем 'радужные' скобки
    let g:lisp_rainbow=1
    " Установить предпочтительную реализацию CommonLisp'а
    let g:slimv_preferred = 'sbcl'
    " Установить нестандартный <Leader>
    let g:slimv_leader='<Plug>Slimv_'

" -----------------------------------------------------------------------------
" YouCompleteMe
" -----------------------------------------------------------------------------

    " Минимальное количество символов, которое нужно ввести для получения
    " вариантов автодополнения на основе имени идентификатора. Установка в
    " занчение 99 отключит анализ на основе идентификатора и оставит только
    " семантический
    let g:ycm_min_num_of_chars_for_completion = 99

    " Скрывать окно с предложенными вариантами автодополнения по нажатии ESC
    let g:ycm_key_list_stop_completion = ['<C-Y>', '<ESC>']
    

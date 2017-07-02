set nocompatible              " be improvquired


" Установить при еноюходимости Plug.vim
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
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

    " Поиск последовательностей из двух символов и перемещение между ними
    Plug 'https://github.com/justinmk/vim-sneak'

    " Показывать теги для текущего файла, загружать при открытии соответствующего окна
    Plug 'https://github.com/majutsushi/tagbar.git'

    " Множественное выделение, как в SublimeText
    Plug 'https://github.com/terryma/vim-multiple-cursors.git'

    " Автодополнение, подсказки при вводе, рефакторинг и т.д.для некоторых ЯП
    " Поддержка:
    "   - C-family (pure c, c++, objective c)
    "   - C#
    Plug 'Valloric/YouCompleteMe', {
        \ 'for': ['c', 'cpp', 'cs'],
        \ 'do': 'git submodule update --init --recursive; ./install.py --clang-completer --omnisharp-completer'
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
    " Plug 'https://github.com/jeaye/color_coded.git'


    " Удобое комментирование
    Plug 'scrooloose/nerdcommenter'

    " Дерево проекта  + взаимодействе с гитом
    Plug 'scrooloose/nerdtree', {
        \ 'on': 'NERDTreeToggle'
    \ }

    " CommonLisp IDE -- SLIMV
    Plug 'https://github.com/kovisoft/slimv.git', {
        \ 'for': 'lisp'
    \ }

" All of your Plugins must be added before the following line

" Initialize plugin system
call plug#end()
filetype plugin indent on    " required


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
    map Y y$

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
    vmap <leader><leader>w :NR<CR>

    " Включить/выключить 'радужные' скобки
    "                                                 [ Leader + Leader + p ]
    nnoremap <leader><leader>p :RainbowParenthesesToggle<CR>


" -----------------------------------------------------------------------------
" Пользовательские типы файлов
" -----------------------------------------------------------------------------


    autocmd BufNewFile,BufRead *.tmpl,*.tpl setfiletype html
    autocmd BufNewFile,BufRead *.h,*.c setfiletype c
    autocmd BufNewFile,BufRead *.ino setfiletype cpp


" -----------------------------------------------------------------------------
" Пользовательские скрипты
" -----------------------------------------------------------------------------


    " Автоматическое создание include guard'ов
    function! InsIncludeGuard()
        let guard_name = "_" . substitute(toupper(expand('%:t')), "\\.", "_", "g") . "_"
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
    nmap <leader><leader>l :set list!<CR>:

    " Внешний вид непечатных символов
    " tab - два символа для отображения табуляции (первый символ и заполнитель)
    " eol - символ для отображения конца строки
    " precedes - индикатор продолжения строки в лево
    " extends - индикатор продолжения строки в право
    set listchars=tab:▸·,eol:¬,precedes:«,extends:»,space:\.


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
    nmap <DOWN> gj
    nmap <UP> gk

    " Ширина строки
    set textwidth=80
    " Для лиспа принимаем ширину окна в 120 символов
    autocmd FileType lisp setlocal textwidth=120


" -----------------------------------------------------------------------------
" Настройки буфера обмена, копирования и вставки
" -----------------------------------------------------------------------------


    " Используем системный буфер в качестве дефолтного
    set clipboard=unnamed

    " Комбинации для копирования и вставки через системный буфер
    "  1. копировать
    "                                                   [ Ctrl + Shift + y  ]
    map <C-S-Y> "+y
    "  2. вставить
    "                                                   [ Ctrl + Shift + p  ]
    map <C-S-P> "+p
    "  3. вырезать
    "                                                   [ Ctrl + Shift + d  ]
    map <C-S-D> "+d


" -----------------------------------------------------------------------------
" Настройки мыши
" -----------------------------------------------------------------------------


    " Включить мышь
    set mouse=a
    
    " Поиск с помощью мыши
    "                                                         [ Shift + ПКМ ]
    "                                                         [ Shift + ЛКМ ]
    set mousemodel=extend


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


    " Отключение курсора на совпадающей парной скобке
    set noshowmatch

    " По-умолчанию отключить подсветку найденных совпадений
    set nohlsearch
    " Клавиша, позволяющая включать и отключать подсветку
    "                                                 [ Leader + Leader + h ]
    nmap <leader><leader>h :set hlsearch!<CR>
    
    " Курсор перемещается к найденному слову в процессе набора
    set incsearch
    
    " Не игнорировать регистр по-умолчанию
    set noignorecase
    " Отключаем умное определение регистра
    set nosmartcase
    " В текстовых файлах, а также в в файлах исходного кода для 
    " регистро-независимых языков игнорировать регист
    autocmd FileType txt,lisp,html,yaml,apache set ignorecase


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


" -----------------------------------------------------------------------------
" Метки
" -----------------------------------------------------------------------------


    " TODO



" -----------------------------------------------------------------------------
" Фолдинг
" -----------------------------------------------------------------------------

    " TODO


" -----------------------------------------------------------------------------
" Проверка орфографии
" -----------------------------------------------------------------------------


    " TODO


" -----------------------------------------------------------------------------
" Сниппеты
" -----------------------------------------------------------------------------

    " UltiSnips
    let g:UltiSnipsExpandTrigger="<C-CR>"
    let g:UltiSnipsListSnippets="<C-TAB>"
    let g:UltiSnipsJumpForwardTrigger="<C-RIGHT>"
    let g:UltiSnipsJumpBackwardTrigger="<C-LEFT>"

" -----------------------------------------------------------------------------
" Комментирование кода (NerdCommenter)
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
" Дополнительные окна
" -----------------------------------------------------------------------------


    " Показывать панель NerdTree по клавише
    "                                                                 [ F5 ]
    map <F5> :NERDTreeToggle<CR> 


    " TagBar
    "                                                                 [ F6 ]
    map <F6> :TagbarToggle<CR>

    " GitGutter
    "                                                                 [ F7 ]
    map <F7> :GitGutterToggle<CR>


" -----------------------------------------------------------------------------
" SLIMV
" -----------------------------------------------------------------------------


    " Не выставлять закрывающие скобки автоматически
    let g:paredit_mode=0
    " включаем 'радужные' скобки
    let g:lisp_rainbow=1


" -----------------------------------------------------------------------------
" YouCompleteMe
" -----------------------------------------------------------------------------



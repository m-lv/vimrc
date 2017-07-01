set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" user defined plugins

    " Автоматически закрывать открытые скобки
    " !! при нажатии стрелки вверх в режиме ввода вставляет 
    " в буфер мусор
    " Plugin 'https://github.com/Townk/vim-autoclose.git'

    " Визуальное оформление
    Plugin 'https://github.com/vim-airline/vim-airline.git'
    Plugin 'https://github.com/vim-airline/vim-airline-themes.git'

    " Интеграция с git
    Plugin 'https://github.com/airblade/vim-gitgutter.git'


    " Показывать теги для текущего файла
    Plugin 'https://github.com/majutsushi/tagbar.git'


    " Множественное выделение, как в SublimeText
    Plugin 'https://github.com/terryma/vim-multiple-cursors.git'


    " Автодополнение, подсказки при вводе, рефакторинг и т.д.для с++
    Plugin 'Valloric/YouCompleteMe' 
    Plugin 'rdnetto/YCM-Generator' " генерация конфигурационного файла


    " Генерация кода
    Plugin 'SirVer/ultisnips'
    Plugin 'honza/vim-snippets'


    " Посветка синтаксиса в pure c/c++/objective c
    " Plugin 'https://github.com/jeaye/color_coded.git'


    " Удобое комментирование
    Plugin 'scrooloose/nerdcommenter'


    " Дерево проекта
    Plugin 'scrooloose/nerdtree'
    " + взаимодействе с гитом
    Plugin 'Xuyuanp/nerdtree-git-plugin'


    " lisp slimv
    Plugin 'https://github.com/kovisoft/slimv.git'

" All of your Plugins must be added before the following line

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


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

    " Возможность переопределять настройки для проекта в локальных .vimrc
    set exrc
    
    " Запрет опасных команд в локальных .vimrc
    set secure


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
    nmap <leader><leader>l :set list!<CR>

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
    " В текстовых документов запретить разрывание
    autocmd FileType txt setlocal nolbr
    " В случае наличия неразорванной длинной строки перемещение курсора вверх и
    " вниз работает более привычно
    nmap j gj
    nmap <DOWN> gj
    nmap k gk
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
    imap <C-S-P> <ESC>l"+pi
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
    " 'Умные' отступы
    set smarttab


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

    autocmd FileType c,cpp set cin

    autocmd FileType txt setlocal nosmarttab autoident


" -----------------------------------------------------------------------------
" Кодировки и раскладка клавиатуры
" -----------------------------------------------------------------------------


    " Дефолтная кодировка
    set ffs=unix,dos,mac
    set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866 

    " Настраиваем переключение раскладок клавиатуры по 
    "                                                           [ Ctrl + ^ ]
    set keymap=russian-jcukenwin

    " Раскладка по умолчанию - английская
    set iminsert=0

" -----------------------------------------------------------------------------
" Оформление
" -----------------------------------------------------------------------------


    " Использовать темный фон
    set background=dark 

    " Открывать новые окна справа
    set splitright

    " Настройка Airline
        " Выбор темы
        let g:airline_theme='simple'
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
" Настройка комбинаций клавиш для YouCompleteMe
" -----------------------------------------------------------------------------


    " Показать результаты диагностики 
    "                                                      [ Leader + y + w ]
    nnoremap <leader>yw  :YcmShowDetailedDiagnostic<CR>

    " Пейти к ...
    "                                                      [ Leader + y + t ]
    nnoremap <leader>yg :YouCompleteMeGoTo<CR>

    " Перейти к объявлению
    "                                                      [ Leader + y + c ]
    nnoremap <leader>yc :YouCompleteMeGoToDeclaration<CR>

    " Перейти к определению
    "                                                      [ Leader + y + f ]
    nnoremap <leader>yf :YouCompleteMeGoToDefinition<CR>

    " Перейти к включению
    "                                                      [ Leader + y + i ]
    nnoremap <leader>yi :YouCompleteMeGoToInclude<CR>

    " Получить документацию
    "                                                      [ Leader + y + d ]
    nnoremap <leader>yd  :YouCompleteMeGetDoc<CR>

    " Переименовать
    "                                                      [ Leader + y + n ]
    nnoremap <leader>yn :YouCompleteMeRefactorRename<CR>


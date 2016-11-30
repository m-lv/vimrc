set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" user defined plugins

" Plugin 'Rip-Rip/clang_complete'
Plugin 'Valloric/YouCompleteMe' 

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'


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


" Установим шелл
set shell=sh

" Чтобы vim показывал подходящие файлыЮ как нормальный шелл
set wildmode=longest:list,full


" Включить мышь
set mouse=a

" Показать номера строк
set number

" Ширина строки
set textwidth=80

" Замена \t на пробелы
set expandtab
" Ширина табуляции в колонках
set ts=4
" Количество пробелов (колонок) одного отступа
set shiftwidth=4

" Умные отступы
set smarttab

" Подсветка синтаксиса
syntax on


" Перенос длинных строк
set wrap

" Используем системный буфер в качестве дефолтного
set clipboard=unnamed


" Дефолтная кодировка
set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866 

" Настройки поиска
set showmatch
set hlsearch
set incsearch
set ignorecase


" Включаем проверку арфаграфии
set spelllang=ru,en


" Включаем сворачвание
" set foldenable           
" на основе отступов по-умолчанию
" set foldmethod=indent
" переключение на сворачивание на основе синтаксиса
map zs :set foldmethod=syntax<CR>
" на основе отступов
map zi :set foldmethod=indent<CR>  


" Более логичноедействие Y, копирование до конца строки
map Y y$



" Специфичные настройки для некоторых типов файлов
    " Отмечаем .h и .c файлы как файлы чистого си
    autocmd BufRead, BufNewFile *.h,*.c set filetype=c.doxygen


    " С/C++ файлы
    " Расставлять отступы в стиле С
    autocmd filetype c,cpp set cin
    

    " make-файл
    " В make-файлах нам не нужно заменять табуляцию пробелам
    autocmd filetype make set noexpandta
    autocmd filetype make set noci
     

    " python-файл
    " Не расставлять отступы в стиле 
    autocmd filetype python set nocin 

" Устанавливаем систему сборки
if has('win32')
    set makeprg=nmake
    compiler msvc
else
    set makeprg=make
    compiler gcc
endif

" Возможность переопределять настройки для проекта в локальных .vimrc
set exrc
" Запрет опасных команд в локальных .vimrc
set secure


" Настройки плагинов
    " Clang-completer                                                                
    " Включить дополнительные подсказки (аргументы функций, шаблонов и т.д.)        
    let g:clang_snippets=1                                                          
    " Использоать ultisnips для дополнительных подсказок (чтобы подсказки шаблонов  
    " автогенерации были в выпадающих меню)                                         
    let g:clang_snippets_engine='ultisnips'                                      
    " Периодически проверять проект на ошибки                                       
    let g:clang_periodic_quickfix=1                                                 
    " Подсвечивать ошибки                                                           
    let g:clang_hl_errors=1
    " Автоматически закрывать окно подсказок после выбора подсказки                 
    let g:clang_close_preview=1   
    " Автоматически показывать подсказки
    let g:clang_complete_auto=1
    " Путь к библиотеке
    let g:clang_library_path='/usr/lib/llvm-3.8/lib/libclang-3.8.so.1'               


    " UltiSnips
    let g:UltiSnipsExpandTrigger="<tab>"


    " NerdCommenter
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



    " NerdTree
    " Показывать панель NerdТree по клавише ctrl + n
    map <C-n> :NERDTreeToggle<CR> 


" Автоматическое создание include guard'ов
function! InsIncludeGuard()
    let guard_name = "_" . substitute(toupper(expand('%:t')), "\\.", "_", "g") . "_"
    execute "normal! 1Go"
    call setline(".", "#ifndef " . guard_name)
    execute "normal! o"
    call setline(".", "#define " . guard_name)
    execute "normal! Go"
    call setline(".", "#endif // " . guard_name)
    execute "normal! o"
endfunction

" Автоматически применять InsIncludeGuard к новым хедерам
autocmd BufNewFile *.{h,hpp,h++} call InsIncludeGuard()


" Вставка комментария-разделителя в стиле С++
function! InsCppSep()
    let length = 80 - 3
    execute "normal! o"
    let text = "// " . repeat("-", length)
    call setline(".", text)
endfunction



" Вставка комментария-заголовка в стиле С++
function! InsCppCaption(text)
    call InsCppSep()
    execute "normal! o"
    call setline(".", "// "  . a:text)
    call InsCppSep()
endfunction



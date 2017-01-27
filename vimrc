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

" Автоматически закрывать открытые скобки
" !! при нажатии стрелки вверх в режиме ввода вставляет 
" в буфер мусор
" Plugin 'https://github.com/Townk/vim-autoclose.git'

" Тут все понятно
Plugin 'https://github.com/vim-airline/vim-airline.git'
Plugin 'https://github.com/vim-airline/vim-airline-themes.git'

" Plugin 'https://github.com/powerline/powerline.git'
" Plugin 'https://github.com/powerline/fonts.git'

" Интеграция с git
Plugin 'https://github.com/airblade/vim-gitgutter.git'

" Показывать теги для текущего файла
Plugin 'https://github.com/majutsushi/tagbar.git'

" Множественное выделение, как SublimeText
Plugin 'https://github.com/terryma/vim-multiple-cursors.git'

" Автодополнение, подсказки при вводе, рефакторинг и т.д.для с++
" Plugin 'Rip-Rip/clang_complete'
Plugin 'Valloric/YouCompleteMe' 
Plugin 'rdnetto/YCM-Generator'

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


" Установим шелл
set shell=sh

" Чтобы vim показывал подходящие файлы, как нормальный шелл
set wildmode=longest:list,full


" Включить мышь
set mouse=a

" Показать номера строк
set number

" Автоматически обновлять файл при изменении сторонней программой
set autoread

" Ширина строки
set textwidth=80
" Не переносить строки
set nowrap

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


" Используем системный буфер в качестве дефолтного
set clipboard=unnamed


" Дефолтная кодировка
set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866 

" более удобная работа с кириллицей. При нажатии <C-6> в режиме вставки, 
" vim изменит режим с "Insert" на "Insert (lang)",
" после чего будут вводиться русские символы. Если вернуться в нормальный 
" режим, то все команды будут работать.
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

" Настройки поиска
set showmatch
set hlsearch
set incsearch
set ignorecase

" Открывать новые окна справа
set splitright

" Включаем проверку арфаграфии
set spelllang=ru,en

" Использовать темный фон
set background=dark

" Настройки фолдинга
" Используем отступы на основе синтаксиса по-умолчанию
" set foldmethod=syntax
" Для текстовых файлов - на основе отступов
" autocmd filetype txt set foldmethod=ident
" Открытие/закрытие на пробел
nnoremap <space> za

" map <alt+n> для перемещения между вкладками
for c in range(1, 9)
	exec "set <A-".c.">=\e".c
	exec "map \e".c." <A-".c.">"

	let n = c - '0'
	exec "map <M-". n ."> ". n ."gt"
endfor

" Более логичное действие Y, копирование до конца строки
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
    " Airline
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
    map <F5> :NERDTreeToggle<CR> 


    " TagBar
    map <F6> :TagbarToggle<CR>

    " GitGutter
    map <F7> :GitGutterToggle<CR>


    " slimv
    " Не выставлять закрывающие скобки автоматически
    let g:paredit_mode=0
    " включаем 'радужные' скобки
    let g:lisp_rainbow=1


" Настройка комбинаций клавиш для YouCompleteMe
nnoremap <leader>yww :YcmShowDetailedDiagnostic<CR>

nnoremap <leader>ygg :YouCompleteMeGoTo<CR>
nnoremap <leader>ygd :YouCompleteMeGoToDeclaration<CR>
nnoremap <leader>ygp :YouCompleteMeGoToDefinition<CR>
nnoremap <leader>ygi :YouCompleteMeGoToInclude<CR>

nnoremap <leader>ydd :YouCompleteMeGetDoc<CR>

nnoremap <leader>yrn :YouCompleteMeRefactorRename<CR>


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

" Автоматически применять InsIncludeGuard к новым хедерам (.h++, .hpp)
autocmd BufNewFile *.{hpp,h++} call InsPragmaOnce()
" Автоматически применять InsIncludeGuard к новым хедерам (.h)
autocmd BufNewFile *.{h} call InsIncludeGuard()


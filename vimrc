set nocompatible              " be iMproved

" -----------------------------------------------------------------------------
"                           Установка плагинов
" -----------------------------------------------------------------------------


  " Установить при необходимости Plug.vim
  if empty(glob("~/.vim/autoload/plug.vim"))
      execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.github.com/junegunn/vim-plug/master/plug.vim'
  endif

  " Зададим путь для установки плагинов
  call plug#begin('~/.vim/plugged')
  " Далее следует список пользовательских плагинов

  " -- интерфейс:
    " Панель статуса и табов
    Plug 'https://github.com/vim-airline/vim-airline.git'

    " Тема
    Plug 'https://github.com/morhetz/gruvbox'

    " Радужные скобки
    Plug 'https://github.com/kien/rainbow_parentheses.vim'

    " Интеграция с git, загружать при открытии соответствующего окна
    Plug 'https://github.com/airblade/vim-gitgutter.git', {
        \ 'on' : 'GitGutterToggle'
    \ }

    " Позволяет открыть выделенный фрагмент в новом окне, отредактировать, а
    " потом снова синхонизировать с остальным текстом
    Plug 'https://github.com/chrisbra/NrrwRgn'

    " Стартовый экран
    Plug 'https://github.com/mhinz/vim-startify'

    " Дерево проекта 
    Plug 'scrooloose/nerdtree', {
        \ 'on': 'NERDTreeToggle'
    \ }

    " Дерево измененений файла
    Plug 'https://github.com/sjl/gundo.vim', {
        \ 'on': 'GundoToggle'
    \ }

    " Показывать теги для текущего файла, загружать при открытии
    " соответствующего окна
    Plug 'https://github.com/majutsushi/tagbar.git'


  " -- простое редактирование
    " Улучшение работы с текстовыми объектами
    " -- TODO: Plug 'https://github.com/paradigm/TextObjectify'

    " Работа со скобками и подобными парными сущностями
    Plug 'https://github.com/tpope/vim-surround'

    " Возврат к английской раскладке после insert mod'а
    " *Требует xkb-switch TODO
    " Plug 'https://github.com/lyokha/vim-xkbswitch'
    
    " Улучшенное поведение .
    Plug 'https://github.com/tpope/vim-repeat'

    " Перемещение блоков текста вверх и вниз
    Plug 'https://github.com/matze/vim-move'

    " Поиск последовательностей из двух символов и перемещение между ними
    Plug 'https://github.com/justinmk/vim-sneak'

    " Множественное выделение, как в SublimeText
    Plug 'https://github.com/terryma/vim-multiple-cursors.git'


  " -- фичи IDE
    " Интерактивный скетчпад (TODO)
    " Не работает. Хуй знает, почему. В пизду пока что
    " Plug 'https://github.com/metakirby5/codi.vim', {
    "      \ 'on': 'Codi!!'
    " \ }

    " Автодополнение
    " Plug 'https://github.com/Shougo/neocomplete.vim'

    " Автодополнение при интеграции с tmux'ом
    " Plug 'https://github.com/wellle/tmux-complete.vim'

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

    " Переключение между файлами исходного кода и реализации в си-подобных
    " языках
    " -- TODO: Plug 'https://github.com/vim-scripts/a.vim', {
        \ 'for': ['c', 'cpp']
    \ }

    " Генерация кода
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " Удобое комментирование
    Plug 'scrooloose/nerdcommenter'

    " CommonLisp IDE -- SLIMV
    Plug 'https://github.com/kovisoft/slimv.git', {
        \ 'for': ['lisp','clojure','hy','scheme','racket']
    \ }


  " Все пользовательские плагины должны быть перечислены до этой строки

  " Инициализируем систему плагинов
  call plug#end()
  filetype plugin indent on    " required


" -----------------------------------------------------------------------------
"                        Пользовательские типы файлов
" -----------------------------------------------------------------------------

  augroup filetypedetect
      autocmd BufNewFile,BufRead *.tmpl,*.tpl setfiletype html
      autocmd BufNewFile,BufRead *.h,*.c setfiletype c
      autocmd BufNewFile,BufRead *.ino setfiletype cpp
  augroup END


" -----------------------------------------------------------------------------
"                           Пользовательские скрипты
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
"                                   Общее
" -----------------------------------------------------------------------------

  " Возможность переопределять настройки для проекта в локальных .vimrc
  set exrc

  " Запрет опасных команд в локальных .vimrc
  set secure

  " Дефолтная кодировка
  set ffs=unix,dos,mac
  set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866 

  " Формат переноса строки
  " set fileformat=dos

  " Настройки путей
    " Автоматически изменять текущий путь в зависимости от выбраного буфера
    autocmd BufEnter * lcd %:p:h
    " Для Си и производных от него языков добавить дополнительные пути
    autocmd FileType c,cpp,objc,objcpp
        \ setlocal path+="src/include,/usr/include/AL,"
    " Для питона настроить преобразование между именами модулей и путями к
    " файлам (простая замена '.' на '/')
    autocmd FileType python
        \ setlocal includeexpr=substitute(v:fname,'\\.','/','g')

  " Сохранять последние изменения
  set undolevels=1000


  " Разрешить создавать swap-файлы
  set swapfile
  " Помещать их в 
  set dir=~/.vim/swapfiles/

  " Разрешим создавать бекапы
  set backup
  " Установим директорию, в которую будут помещаться файлы бекапов
  set backupdir=~/.vim/backups/

" -----------------------------------------------------------------------------
"                              Настройки интерфейса
" -----------------------------------------------------------------------------

  " -- настройки шелла
    " Установим шелл
    set shell=sh
    " Автоподстановка в шелле
    set wildmode=longest:list,full
    " Не использовать файлы перечисленных типов при автоподстановке
    set wildignore+=.hg,.git,.svn
    set wildignore+=*.pyc

  " -- настроим меню
    set wildmenu
    set wcm=<TAB>
    noremap <C-M> :emenu<SPACE><TAB>

  " Показать номера строк
  set number

  " Включить/выключить подсветку положения курсора(по-умолчанию -- нет)
  "                                                [ Leader + Leader + C ]
  "                                             [ Leader + Leader + Shift-C ]
  set nocursorline nocursorcolumn
  noremap <silent> <leader><leader>c :set cursorcolumn!<CR>
  noremap <silent> <leader><leader>C :set cursorline!<CR>

  " Автоматически обновлять файл при изменении сторонней программой
  set autoread

  " Минимальное расстояние от экрана до курсора
  set scrolloff=6

  " Подсветка синтаксиса
  syntax on

  " -- настройки стартового экрана
    " Сохранять сессии
    let g:startify_session_persistence = 1
    " Список разделов, которые будут представлены на стартовом экране 
    let g:startify_list_order = [
        \ [ 'Recently used files:' ],
        \ 'files', 
        \ [ 'Recently used sessions' ],
        \ 'sessions', 
        \ [ 'Bookmarks' ],
        \ 'bookmarks'
    \ ]
    " Максимальное количество отображаемых файлов
    let g:startify_files_number=5
    " Список доступных закладок
    let g:startify_bookmarks = [ 
        \ {'c': '~/.vim/vimrc'}
    \ ]
    " Вернуться к стартовому экрану
    "                                                       [ F2 ]
    noremap <F2> :Startify<CR>
    

  " -- манипуляции с окнам(views) и табами(tabs)
    " Изменение размеров окон
    "                                                   [ Ctrl-Alt-Left ]
    "                                                  [ Ctrl-Alt-Right ]
    noremap <C-A-LEFT> <C-W><
    noremap <C-A-RIGHT> <C-W>>
    noremap <C-A-UP> <C-W>+  
    noremap <C-A-DOWN> <C-W>-

    " Переход между окнами
    "                                                    [ Alt-Left ]
    "                                                   [ Alt-Right ]
    noremap <A-LEFT> <C-W><LEFT>
    noremap <A-RIGHT> <C-W><RIGHT>
    noremap <A-UP> <C-W><UP>
    noremap <A-DOWN> <C-W><DOWN>

    " Закрыть окно без сохранения
    "                                                   [ Ctrl-W + Shift-Q ]
    noremap <C-W><S-Q> :q!<CR>

    " Редактировать выделенный текст в новом окне
    "                                                [ Leader + Leader + W ]
    vnoremap <silent> <leader><leader>w :NR<CR>

    " Комбинации клавишь для переключения между буферами
    "                                                  [ Ctrl + PageUp ]
    "                                                 [ Ctrl + PageDown ]
    noremap <silent> <C-PAGEDOWN> :bnext<CR>
    noremap <silent> <C-PAGEUP> :bprevious<CR>


  " -- отображение дополнительных элементов
    " Комбинация для скрытия/отображения непечатных символов
    "                                           [ Leader + leader + L ]
    noremap <silent> <leader><leader>l :set list!<CR>:set list?<CR>
    " Их внешний вид
    " tab - два символа для отображения табуляции (первый символ и заполнитель)
    " eol - символ для отображения конца строки
    " precedes - индикатор продолжения строки в лево
    " extends - индикатор продолжения строки в право
    set listchars=tab:▸·,eol:¬,precedes:«,extends:»,space:\.

    " По-умолчанию отключить подсветку при поиске
    set nohlsearch
    " Комбинация, позволяющая включать и отключать подсветку
    "                                           [ Leader + Leader + H ]
    noremap <silent> <leader><leader>h :set hlsearch!<CR>:set hlsearch?<CR>

    " NerdTree
    "                                                       [ F5 ]
    noremap <silent> <F5> :NERDTreeToggle<CR> 
    " TagBar
    "                                                       [ F6 ]
    noremap <silent> <F6> :TagbarToggle<CR>
    " GitGutter
    "                                                       [ F7 ]
    noremap <silent> <F7> :GitGutterToggle<CR>
    " Gundo
    "                                                       [ F8 ]
    noremap <silent> <F8> :GundoToggle<CR>
    " Gundo использует Python3 по-умолчанию
    let g:gundo_prefer_python3=1
    " Показывать интерактивный скетчпад
    "                                                      [ F12 ]
    noremap <F12> <NOP>
    autocmd FileType python
        \ noremap <buffer> <silent> <F12> :Codi!!<CR>


  " -- длинные строки 
    " Включить перенос(визуальный) по словам, если длина строки слишком велика
    set wrap
    " Запретить 'разрывание' длинных строк
    set linebreak
    " Показывать символ ↪ при переносе длинных строк
    let &sbr = nr2char(8618).' '
    " В случае наличия неразорванной длинной строки перемещение курсора вверх и
    " вниз работает более привычно
    nnoremap <DOWN> gj
    nnoremap <UP> gk
    " Показывать справа максимальную приемлимую длину строки
    set colorcolumn=81
    " Ширина строки
    set textwidth=80
    " Для лиспа принимаем ширину окна в 120 символов
    autocmd FileType lisp,clojure,hy,scheme,racket 
        \ setlocal colorcolumn=121 textwidth=120


  " --мышь
    " Включить
    set mouse=a
    " Поиск с помощью мыши
    "                                                    [ Shift-ПКМ ]
    "                                                    [ Shift-ЛКМ ]
    set mousemodel=extend
    " При нажатии средней клавиши мыши вставлять текст позицию указателя мыши,
    " а не курсора
    "                                                       [ СКМ ]
    noremap <silent> <MiddleMouse> <LeftMouse><MiddleMouse>
    noremap! <silent> <MiddleMouse> <LeftMouse><MiddleMouse>


  " Установить тёмый фон
  set background=dark

  " -- тема Gruvbox
    " Включить наклонный шрифт
    let g:gruvbox_italic = 1
    " Включить наклонный шрифт
    let g:gruvbox_termcolor = 256
    " Контрастность
    let g:gruvbox_contrast_dark = 'hard'
    " Установить тему
    colorscheme gruvbox


  " -- Airline
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


  " -- folding
    " Отключить сворачивание по-умолчанию
    set nofoldenable
    " Комбинация для включения/выключения
    "                                           [ Leader + Leader + F ]
    noremap <silent> <leader><leader>f :set foldenable!<CR>:set foldenable?<CR>
    " Свернуть/развернуть
    "                                                  [ Space ]
    noremap <silent> <Space> za
    " Свернуть все блоки
    "                                               [ Z + Shift-C ]
    noremap zC zM
    " Развернуть все блоки
    "                                               [ Z + Shift-O ]
    noremap zO zR
    " К следующей свертке
    "                                                  [ Z + N ]
    noremap zn zk
    " К предыдущей свертке
    "                                                  [ Z + B ]
    noremap zb zj
    " При редактировании vimrc включить сворачивание на основе отступов
    autocmd BufNewFile,BufRead vimrc,.vimrc setlocal foldmethod=indent


  " -- Codi
    " " Установить ширину доп. окна в 80 символов
    " let g:codi#width=80
    " " Обновлять окно при вводе текста
    " let g:codi#autocmd = 'TextChanged'
    " " Список инетрпретаторов
    " let g:codi#interpreters = {
    "     \ 'python': { 'bin': 'python' },
    " \ }
    " " Включить лог
    " let g:codi#log = expand('~/.vim/codi_log')


" -----------------------------------------------------------------------------
"                             Простое редактирование
" -----------------------------------------------------------------------------

  " Более логичное действие Y -- копирование до конца строки
  noremap Y y$

  " В режиме выделения повесить функционал плагина vim.surround на клавишу
  "                                                         [ S ]
  vmap s S

  " Не снимать выделение после использования > и <
  vnoremap < <gv
  vnoremap > >gv
  " Использовать в визуальном режиме , и . как < и > 
  vmap , <
  vmap . >

  " При нажатии Shift вместе со стрелкой выделять текст
  nnoremap <S-UP> <S-V><UP>
  nnoremap <S-DOWN> <S-V><DOWN>
  nnoremap <S-RIGHT> <S-V><RIGHT>
  nnoremap <S-LEFT> <S-V><LEFT>

  vnoremap <S-UP> <UP>
  vnoremap <S-DOWN> <DOWN>
  vnoremap <S-RIGHT> <RIGHT>
  vnoremap <S-LEFT> <LEFT>

  " -- манипуляции со строками
    " Отключаем стандартные биндиги для плагина Move(перемещение строк
    " вверх/вниз)    
    let g:move_map_keys = 0
    " Настраиваем свои комбинации
    "                                                  [ Ctrl-Shift-Up ]
    "                                                 [ Ctrl-Shift-Down ]
    map <silent> <C-UP> <Plug>MoveLineUp
    map <silent> <C-DOWN> <Plug>MoveLineDown
    vmap <silent> <C-UP> <Plug>MoveBlockUp
    vmap <silent> <C-DOWN> <Plug>MoveBlockDown

    " Дублирование строк или выделенных фрагментов текста
    noremap <C-S-UP> yyP
    noremap <C-S-DOWN> yyp
    vnoremap <C-S-UP> dPp
    vnoremap <C-S-DOWN> dPp

    " Перемещение/копирование строк/выделнного текста в соседнее окно
    "                                                  [ Ctrl-Shift-Left ]
    "                                                 [ Ctrl-Shift-Right ]
    "                                                    [ Ctrl-Left ]
    "                                                   [ Ctrl-Right ]
    nnoremap <C-S-LEFT> yy<C-W><LEFT>P<CR><C-W><RIGHT>
    nnoremap <C-LEFT> dd<C-S-W><LEFT>P<CR><C-W><RIGHT>
    vnoremap <C-S-LEFT> y<C-W><LEFT>gP<C-W><RIGHT>
    vnoremap <C-LEFT> d<C-S-W><LEFT>gP<C-W><RIGHT>

    vnoremap <C-S-RIGHT> y<C-W><RIGHT>gP<C-W><LEFT>
    vnoremap <C-RIGHT> d<C-S-W><RIGHT>gP<C-W><LEFT>
    nnoremap <C-S-RIGHT> yy<C-W><RIGHT>P<CR><C-W><LEFT>
    nnoremap <C-RIGHT> dd<C-S-W><RIGHT>P<CR><C-W><LEFT>


  " -- комбинации для копирования и вставки через системный буфер
    "  1. копировать
    "                                              [ Ctrl-Shift-Y ]
    noremap <C-S-Y> "+y
    noremap <C-S-Y><C-S-Y> "+yy
    "  2. вставить
    "                                              [ Ctrl-Shift-P ]
    noremap <C-S-P> "+p
    "  3. вырезать
    "                                              [ Ctrl-Shift-D ]
    noremap <C-S-D> "+d
    noremap <C-S-D><C-S-D> "+dd


  " Улучшенное поведение f, F, t и T
  map <silent> f <Plug>Sneak_f
  map <silent> F <Plug>Sneak_F
  map <silent> t <Plug>Sneak_t
  map <silent> T <Plug>Sneak_T

  " Поиск последовательности из 2 симовлов
  "                                                        [ H ]
  "                                                     [ Shift-H ]
  map <silent> h  <Plug>Sneak_s
  map <silent> H  <Plug>Sneak_S

  " -- настройки отступов
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
    autocmd BufNewFile,BufRead vimrc,.vimrc 
        \ setlocal ts=2 sw=2 sts=2 et


  " -- поиск по тексту
    " При поиске останавливаться в конце файла
    set nowrapscan
    " Вообще хз, что это такое
    set noshowmatch
    " Курсор перемещается к найденному слову в процессе набора
    set incsearch
    " Не игнорировать регистр по-умолчанию
    set noignorecase
    " Комбинация для переключения этого параметра
    "                                                 [ Leader + Leader + I ]
    noremap <silent> <leader><leader>i 
        \ :setlocal ignorecase!<CR>:set ignorecase?<CR>
    " Включить автодополнение
    set infercase
    " Отключить 'умное' определение регистра
    set nosmartcase
    " В текстовых файлах, а также в в файлах исходного кода для 
    " регистро-независимых языков игнорировать регистр
    autocmd FileType txt,html,yaml,apache set ignorecase
    autocmd FileType lisp,clojure,hy,scheme,racket set ignorecase



" -----------------------------------------------------------------------------
"                                  Функции IDE
" -----------------------------------------------------------------------------

  " -- комментирование
    " Закомментировать строку или выделенные блок
    "                                                 [ Leader + C + C]
    map <leader>cc <plug>NERDCommenterComment
    " Закомментировать строку или выделенные блок (Sexy Comment)
    "                                                 [ Leader + C + S]
    map <leader>cs <plug>NERDCommenterSexy
    " Раскомментировать строку или выделенные блок
    "                                                 [ Leader + C + U]
    map <leader>cu <plug>NERDCommenterUncomment


  " -- документирование
    " Получить тип данных сущности под курсором
    "                                                 [ Leader + C + T]
    noremap <buffer> <leader>ct <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>ct :YcmCompleter GetType<CR>
    " Аналогично предыдущему, но не вызывает перекомпиляцию файла
    "                                              [ Leader + C + Shift-T]
    noremap <buffer> <leader>cT <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>cT :YcmCompleter GetTypeImprecise<CR>

    " Получить семантического предка сущности под курсором
    "                                                 [ Leader + C + P]
    noremap <buffer> <leader>cp <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>cp :YcmCompleter GetParent<CR>

    " Получить документацию по сущности под курсором
    "                                                 [ Leader + C + D]
    noremap <buffer> <leader>cd <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>cd :YcmCompleter GetDoc<CR>
    autocmd FileType cs 
        \ noremap <buffer> <leader>cd :YcmCompleter GetDoc<CR>
    " Аналогично предыдущему, но не вызывает перекомпиляцию файла
    "                                              [ Leader + C + Shift-D]
    noremap <buffer> <leader>cD <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>cD :YcmCompleter GetDocImprecise<CR>
    autocmd FileType cs 
        \ noremap <buffer> <leader>cD :YcmCompleter GetDocImprecise<CR>
    

  " -- рефакторинг
    " FixIt
    "                                                 [ Leader + R + F ]
    noremap <buffer> <leader>rf <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>rf :YcmCompleter FixIt<CR>
    autocmd FileType cs 
        \ noremap <buffer> <leader>rf :YcmCompleter FixIt<CR>

    " Переименовать сущность под курсором
    "                                                 [ Leader + R + N ]
    noremap <buffer> <leader>rn <NOP>


  " -- переходы
    " TODO: реализовать аналогичный функционал для Lisp'а и Python'а
    " Семейство команд GoTo
    "   Перейти к хедеру/ импортируемому файлу
    "                                                 [ Leader + G + I ]
    noremap <buffer> <leader>gi <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>gi :YcmCompleter GoToInclude<CR>

    "   Перейти к объявлению
    "                                                 [ Leader + G + C ]
    noremap <buffer> <leader>gc <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>gc :YcmCompleter GoToDeclaration<CR>
    autocmd FileType cs 
        \ noremap <buffer> <leader>gc :YcmCompleter GoToDeclaration<CR>
    " autocmd FileType python 
    "   \ noremap <buffer> <leader>gc :YcmCompleter GoToDeclaration<CR>

    "   Перейти к определению
    "                                                 [ Leader + G + D ]
    noremap <buffer> <leader>gd <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>gd :YcmCompleter GoToDefinition<CR>
    autocmd FileType cs 
        \ noremap <buffer> <leader>gd :YcmCompleter GoToDefinition<CR>
    " autocmd FileType python 
    "   \ noremap <buffer> <leader>gd :YcmCompleter GoToDefinition<CR>

    "   Автоматически подобрать тип перехода и выполнить его
    "                                                 [ Leader + G + G ]
    noremap <buffer> <leader>gg <NOP>
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>gg :YcmCompleter GoTo<CR>
    autocmd FileType cs 
        \ noremap <buffer> <leader>gi :YcmCompleter GoTo<CR>
    " autocmd FileType python noremap <buffer> <leader>gi :YcmCompleter GoTo<CR>

    "   Ускоренный аналог предыдущей команы. Не перекомпилирует файл перед
    "   вызовом
    "                                             [ Leader + g + Shift-G ]
    autocmd FileType c,cpp,objc,objcpp 
        \ noremap <buffer> <leader>gG :YcmCompleter GoToImprecise<CR>

  " -- копии инструкций перехода с открытием нового таба
  "                                           [ аналогично, но с Ctrl+G ]
    noremap <C-G>g :vsplit<CR><C-W>wgg
    noremap <C-G><C-G> :vsplit<CR><C-W>wgg
    noremap <C-G> :vsplit<CR><C-W>wG
    noremap <C-G>f :vsplit<CR><C-W>wgf 
    map <leader><C-G>c :vsplit<CR><C-W>w<leader>gi
    map <leader><C-G>f :vsplit<CR><C-W>w<leader>gf
    map <leader><C-G>g :vsplit<CR><C-W>w<leader>gg
    map <leader><C-G><C-G> :vsplit<CR><C-W>w<leader>gg
    map <leader><C-G>G :vsplit<CR><C-W>w<leader>gG
    map <leader><C-G><C-S-G> :vsplit<CR><C-W>w<leader>gG


  " -- отладка
    " TODO

  " -- сборка/выполнение
    " Загрузить текущую конфигурацию vimrc
    "                                              [ Leader + Leader + U ]
    autocmd BufNewFile,BufRead vimrc,.vimrc 
        \ noremap <buffer> <leader><leader>u :source $MYVIMRC<CR>

    " Настроить команды сборки для различных языков программирования
    autocmd FileType c,cpp,objc,objcpp,make
        \ setlocal makeprg=make\ -C\ ../build\ -j9

    " Собирать проект по нажатии на 
    "                                                     [ F3 ]
    noremap <F3> :make!<CR>



  " -- Slimv
    " Не выставлять закрывающие скобки автоматически
    let g:paredit_mode=0
    " включаем 'радужные' скобки
    let g:lisp_rainbow=1
    " Установить предпочтительную реализацию CommonLisp'а
    let g:slimv_preferred = 'sbcl'
    " Установить нестандартный <Leader>
    let g:slimv_leader='<Plug>Slimv_'

  " -- NerdCommenter
    " Добавлять пробел перед текстом комментария
    let g:NERDSpaceDelims=1
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs=1
    " Align line-wise comment delimiters flush left instead of following code
    " indentation
    let g:NERDDefaultAlign = 'left'
    " Пример использования собственного стиля комментирования
    let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
    " Allow commenting and inverting empty lines (useful when commenting a
    " region)
    let g:NERDCommentEmptyLines=1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace=1


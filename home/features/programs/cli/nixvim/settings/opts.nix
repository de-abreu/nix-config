{
  clipboard = "unnamedplus"; # Set nixvim's clipboard to be the same as system's

  # Completion and popups
  pumheight = 10; # Maximum number of items to show in the popup menu (0 means "use available screen space")
  infercase = true;

  # Editor behaviour
  virtualedit = "block"; # Allow cursor to move where there is no text in visual block mode
  startofline = true;
  title = true;
  backup = false;

  grepprg = "rg --vimgrep";
  grepformat = "%f:%l:%c:%m";

  scrolloff = 8; # Will never have less than 8 characters as you scroll down
  mouse = ""; # Disable mouse
  encoding = "utf-8";

  # Files and buffers
  swapfile = false;
  undofile = true;
  autoread = true;
  writebackup = false;
  fileencoding = "utf-8";
  modeline = true; # Scan for editor directives like 'vim: set ft=nix:'
  modelines = 100; # Scan first/last 100 lines for modelines

  # Identation and formatting
  tabstop = 2; # Follow shiftwidth
  shiftwidth = 2;
  expandtab = true;
  autoindent = true;
  copyindent = true;
  preserveindent = true;

  # Messages and command line
  cmdheight = 0; # Hide command line when not in use
  history = 100; # Command history limit
  report = 9001; # Disable "x more/fewer lines" messages

  # Performance
  updatetime = 100; # CursorHold delay; faster completion and git signs
  lazyredraw = false; # Breaks noice plugin
  synmaxcol = 240; # Disable syntax highlighting for long lines
  timeoutlen = 500; # Key sequence timeout (ms)

  # Search
  incsearch = true; # As the pattern is being typed, highlight all the current matches
  ignorecase = true; # Case-insensitive search
  smartcase = true; # Unless pattern contains uppercase
  hlsearch = true; # Highlight all matches

  # Softwrap
  wrap = true; # Enable line wrapping
  linebreak = true; # Break lines at "breakat" characters, thus not splitting words
  breakindent = true; # Preserve indentation when breaking lines
  whichwrap = "b,s,h,l"; # Set keys which can make the cursor wrap lines

  # Spelling
  spell = true;
  spelllang = ["en_us" "pt_br" "ro"];

  # Window splits
  splitbelow = true; # When splitting a window horizontally, place the newly created window below the currently active window
  splitright = true; # When splitting a window vertically, place the newly created window to the right of the currently active window

  # UI
  number = true;
  relativenumber = true;
  cursorline = true; # Highlight the line where the cursor is located
  cursorcolumn = false;
  signcolumn = "yes"; # Enable the sign column to prevent the screen from jumping
  laststatus = 3; # Global statusline
  showmode = false; # Don't show the editor mode in status line
  showmatch = true;
  matchtime = 1; # Flash duration in deciseconds
  termguicolors = true; # Better colors
  winborder = "rounded";
}

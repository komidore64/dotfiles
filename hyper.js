// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    // choose either `'stable'` for receiving highly polished,
    // or `'canary'` for less polished but more frequent updates
    updateChannel: 'stable',

    // default font size in pixels for all tabs
    fontSize: 12,

    // font family with optional fallbacks
    fontFamily: '"Source Code Pro", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',

    // default font weight: 'normal' or 'bold'
    fontWeight: 'normal',

    // font weight for bold characters: 'normal' or 'bold'
    fontWeightBold: 'bold',

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: 'rgba(248,28,229,0.8)',

    // terminal text color under BLOCK cursor
    cursorAccentColor: '#2E3436',

    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
    cursorShape: 'BLOCK',

    // set to `true` (without backticks and without quotes) for blinking cursor
    cursorBlink: true,

    // color of the text
    foregroundColor: '#ededed',

    // terminal background color
    // opacity is only supported on macOS
    backgroundColor: '#101010',

    // terminal selection color
    selectionColor: 'rgba(248,28,229,0.3)',

    // border color (window, tabs)
    borderColor: '#000',

    // custom CSS to embed in the main window
    css: '',

    // custom CSS to embed in the terminal window
    termCSS: '',

    // if you're using a Linux setup which show native menus, set to false
    // default: `true` on Linux, `true` on Windows, ignored on macOS
    showHamburgerMenu: true,

    // set to `false` (without backticks and without quotes) if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` (without backticks and without quotes) on Windows and Linux, ignored on macOS
    showWindowControls: true,

    // custom padding (CSS format, i.e.: `top right bottom left`)
    padding: '12px 14px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black: '#2E3436',
      red: '#993C3C',
      green: '#3C993C',
      yellow: '#99993C',
      blue: '#3C6199',
      magenta: '#993C99',
      cyan: '#3C9999',
      white: '#D3D7CF',
      lightBlack: '#555753',
      lightRed: '#BF4141',
      lightGreen: '#41BF41',
      lightYellow: '#BFBF41',
      lightBlue: '#4174FB',
      lightMagenta: '#BF41BF',
      lightCyan: '#41BFBF',
      lightWhite: '#E3E3E3',
    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    //
    // Windows
    // - Make sure to use a full path if the binary name doesn't work
    // - Remove `--login` in shellArgs
    //
    // Bash on Windows
    // - Example: `C:\\Windows\\System32\\bash.exe`
    //
    // PowerShell on Windows
    // - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
    shell: '',

    // for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
    // by default `['--login']` will be used
    shellArgs: ['--login'],

    // for environment variables
    env: {},

    // set to `false` for no bell
    bell: 'SOUND',

    // if `true` (without backticks and without quotes), selected text will automatically be copied to the clipboard
    copyOnSelect: true,

    // if `true` (without backticks and without quotes), hyper will be set as the default protocol client for SSH
    defaultSSHApp: true,

    // if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
    // selection is present (`true` by default on Windows and disables the context menu feature)
    // quickEdit: true,

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // for advanced config flags please refer to https://hyper.is/#cfg
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],

  keymaps: {
    "window:devtools": "ctrl+shift+i",
    "window:reload": "ctrl+shift+r",
    "window:reloadFull": "ctrl+shift+f5",
    "window:preferences": "",
    "zoom:reset": "ctrl+0",
    "zoom:in": "ctrl+shift+=",
    "zoom:out": "ctrl+-",
    "window:new": "",
    "window:minimize": "",
    "window:zoom": "",
    "window:toggleFullScreen": "",
    "window:close": "",
    "tab:new": "",
    "tab:next": [
      "ctrl+shift+]",
      "ctrl+shift+right",
      "ctrl+alt+right",
      "ctrl+tab"
    ],
    "tab:prev": [
      "ctrl+shift+[",
      "ctrl+shift+left",
      "ctrl+alt+left",
      "ctrl+shift+tab"
    ],
    "tab:jump:prefix": "ctrl",
    "pane:next": "",
    "pane:prev": "",
    "pane:splitVertical": "",
    "pane:splitHorizontal": "",
    "pane:close": "",
    "editor:undo": "",
    "editor:redo": "",
    "editor:cut": "",
    "editor:copy": "",
    "editor:paste": "",
    "editor:selectAll": "",
    "editor:movePreviousWord": "",
    "editor:moveNextWord": "",
    "editor:moveBeginningLine": "",
    "editor:moveEndLine": "",
    "editor:deletePreviousWord": "",
    "editor:deleteNextWord": "",
    "editor:deleteBeginningLine": "",
    "editor:deleteEndLine": "",
    "editor:clearBuffer": "",
    "editor:break": "",
    "plugins:update": ""
  },
};

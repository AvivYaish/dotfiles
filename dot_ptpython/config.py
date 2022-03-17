"""
Configuration example for ``ptpython``.
Copy this file to $XDG_CONFIG_HOME/ptpython/config.py
On Linux, this is: ~/.config/ptpython/config.py
"""
from prompt_toolkit.filters import ViInsertMode
from prompt_toolkit.key_binding.key_processor import KeyPress
from prompt_toolkit.keys import Keys
from prompt_toolkit.styles import Style

from ptpython.layout import CompletionVisualisation

__all__ = ["configure"]


def configure(repl):
    """
    Configuration method. This is called during the start-up of ptpython.
    :param repl: `PythonRepl` instance.
    """
    # Show function signature (bool).
    repl.show_signature = True

    # Show docstring (bool).
    repl.show_docstring = True

    # Show completions. (NONE, POP_UP, MULTI_COLUMN or TOOLBAR)
    repl.completion_visualisation = CompletionVisualisation.POP_UP

    # When CompletionVisualisation.POP_UP has been chosen, use this
    # scroll_offset in the completion menu.
    repl.completion_menu_scroll_offset = 0

    # Show line numbers (when the input contains multiple lines.)
    repl.show_line_numbers = True

    # Show status bar.
    repl.show_status_bar = True

    # When the sidebar is visible, also show the help text.
    repl.show_sidebar_help = True

    # Highlight matching parethesis.
    repl.highlight_matching_parenthesis = True

    # Line wrapping. (Instead of horizontal scrolling.)
    repl.wrap_lines = True

    # Mouse support.
    repl.enable_mouse_support = True

    # Complete while typing. (Don't require tab before the
    # completion menu is shown.)
    repl.complete_while_typing = True

    # Fuzzy and dictionary completion.
    repl.enable_fuzzy_completion = True
    repl.enable_dictionary_completion = True

    # Vi mode.
    repl.vi_mode = True

    # Paste mode. (When True, don't insert whitespace after new line.)
    repl.paste_mode = False

    # Use the classic prompt. (Display '>>>' instead of 'In [1]'.)
    repl.prompt_style = "ipython"  # 'classic' or 'ipython'

    # Don't insert a blank line after the output.
    repl.insert_blank_line_after_output = False

    # History Search.
    # When True, going back in history will filter the history on the records
    # starting with the current input. (Like readline.)
    # Note: When enable, please disable the `complete_while_typing` option.
    #       otherwise, when there is a completion available, the arrows will
    #       browse through the available completions instead of the history.
    repl.enable_history_search = False

    # Enable auto suggestions. (Pressing right arrow will complete the input,
    # based on the history.)
    repl.enable_auto_suggest = True

    # Enable open-in-editor. Pressing C-x C-e in emacs mode or 'v' in
    # Vi navigation mode will open the input in the current editor.
    repl.enable_open_in_editor = True

    # Enable system prompt. Pressing meta-! will display the system prompt.
    # Also enables Control-Z suspend.
    repl.enable_system_bindings = True

    # Ask for confirmation on exit.
    repl.confirm_exit = True

    # Enable input validation. (Don't try to execute when the input contains
    # syntax errors.)
    repl.enable_input_validation = True

    # Use this colorscheme for the code.
    # Ptpython uses Pygments for code styling, so you can choose from Pygments'
    # color schemes. See:
    # https://pygments.org/docs/styles/
    # https://pygments.org/demo/
    # repl.use_code_colorscheme("monokai")
    # A colorscheme that looks good on dark backgrounds is 'native':
    # repl.use_code_colorscheme("native")

    # Install custom colorscheme named 'my-colorscheme' and use it.
    # Custom colorscheme for the UI. See `ptpython/layout.py` and
    # `ptpython/style.py` for all possible tokens.
    dracula_code_colorscheme = {
        "pygments.comment": "#6272a4",
        "pygments.keyword": "#ff79c6",
        "pygments.number": "#bd93f9",
        "pygments.operator": "#ff79c6",
        "pygments.string": "#f1fa8c",
        "pygments.name": "#f8f8f2",
        "pygments.name.decorator": "#f8f8f2",
        "pygments.name.class": "#50fa7b",
        "pygments.name.function": "#50fa7b",
        "pygments.name.builtin": "#8be9fd italic",
        "pygments.name.attribute": "#50fa7b",
        "pygments.name.constant": "#f8f8f2",
        "pygments.name.entity": "#f8f8f2",
        "pygments.name.exception": "#f8f8f2",
        "pygments.name.label": "#8be9fd italic",
        "pygments.name.namespace": "#f8f8f2",
        "pygments.name.tag": "#ff79c6",
        "pygments.name.variable": "#8be9fd italic",
    }
    onedark_code_colorscheme = {
        "pygments.token": "#ABB2BF",

        "pygments.punctuation": "#ABB2BF",
        "pygments.punctuation.marker": "#ABB2BF",

        "pygments.comment": "#7F848E",
        "pygments.keyword": "#C678DD",

        "pygments.keyword.constant": "#E5C07B",
        "pygments.keyword.declaration": "#C678DD",
        "pygments.keyword.namespace": "#C678DD",
        "pygments.keyword.reserved": "#C678DD",
        "pygments.keyword.type": "#E5C07B",

        "pygments.number": "#D19A66",
        "pygments.operator": "#56B6C2",
        "pygments.string": "#98C379",
        "pygments.name": "#E06C75",
        "pygments.name.decorator": "#61AFEF",
        "pygments.name.class": "#E5C07B",
        "pygments.name.function": "#61AFEF bold",
        "pygments.name.function.magic": "#56B6C2 bold",
        "pygments.name.builtin": "#E5C07B",
        "pygments.name.attribute": "#E06C75",
        "pygments.name.tag": "#E06C75",
        "pygments.name.other": "#E06C75",
    }
    repl.install_code_colorscheme("onedark", Style.from_dict(onedark_code_colorscheme))
    repl.use_code_colorscheme("onedark")

    # Set color depth (keep in mind that not all terminals support true color).

    # repl.color_depth = "DEPTH_1_BIT"  # Monochrome.
    # repl.color_depth = "DEPTH_4_BIT"  # ANSI colors only.
    repl.color_depth = "DEPTH_8_BIT"  # The default, 256 colors.
    # repl.color_depth = "DEPTH_24_BIT"  # True color.

    # Min/max brightness
    repl.min_brightness = 0.0  # Increase for dark terminal backgrounds.
    repl.max_brightness = 1.0  # Decrease for light terminal backgrounds.

    # Syntax.
    repl.enable_syntax_highlighting = True

    # Get into Vi navigation mode at startup
    repl.vi_start_in_navigation_mode = False

    # Preserve last used Vi input mode between main loop iterations
    repl.vi_keep_last_used_mode = False

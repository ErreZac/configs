from libqtile import widget
from rose_pine_moon import colorz
#
def right_slant():
    return widget.TextBox(
            fontsize=42, 
            padding=4,
            fmt='', 
            background=colorz["black"], 
            foreground=colorz["green"], 
            )

def left_slant():
    return widget.TextBox(
            fontsize=42, 
            padding=4,
            fmt='', 
            background=colorz["black"], 
            foreground=colorz["green"], 
            )


def right_half_slant():
    return widget.TextBox(
            fontsize=42, 
            fmt=' ', 
            background=colorz["black"] + "e6", 
            foreground=colorz["black"], 
            )

def left_half_slant():
    return widget.TextBox(
            fontsize=42, 
            fmt=' ', 
            background=colorz["black"] + "e6", 
            foreground=colorz["black"], 
            )

def right_rev_slant():
    return widget.TextBox(
            fontsize=42, 
            fmt=' ', 
            background=colorz["black"] + "e6", 
            foreground=colorz["black"], 
            )

def left_rev_slant():
    return widget.TextBox(
            fontsize=42, 
            fmt=' ', 
            background=colorz["black"] + "e6", 
            foreground=colorz["black"], 
            )

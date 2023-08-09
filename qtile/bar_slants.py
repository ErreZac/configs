from libqtile import widget

def right_slant():
    return widget.TextBox(
            fontsize=42, 
            padding=4,
            fmt='', 
            background='#191724', 
            foreground='#f6c177', 
            )

def left_slant():
    return widget.TextBox(
            fontsize=42, 
            padding=4,
            fmt='', 
            background='#191724', 
            foreground='#f6c177', 
            )


def right_half_slant():
    return widget.TextBox(
            fontsize=42, 
            fmt=' ', 
            # background='#403d52', #'#e0def400', 
            background='#191724e6',
            foreground='#191724'
            )

def left_half_slant():
    return widget.TextBox(
            fontsize=42, 
            fmt=' ', 
            # background='#403d52', #'#e0def400', 
            background='#191724e6',
            foreground='#191724'
            )

def right_rev_slant():
    return widget.TextBox(
            fontsize=42, 
            fmt=' ', 
            # background='#403d52', #'#e0def400', 
            background='#191724e6',
            foreground='#191724'
            )

def left_rev_slant():
    return widget.TextBox(
            fontsize=42, 
            fmt=' ', 
            # background='#403d52', #'#e0def400', 
            background='#191724e6',
            foreground='#191724'
            )

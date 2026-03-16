#!/usr/bin/env python3
import time
from datetime import datetime

DIGITS = {
    "0": ["███","█ █","█ █","█ █","███"],
    "1": [" ██","  █","  █","  █","███"],
    "2": ["███","  █","███","█  ","███"],
    "3": ["███","  █","███","  █","███"],
    "4": ["█ █","█ █","███","  █","  █"],
    "5": ["███","█  ","███","  █","███"],
    "6": ["███","█  ","███","█ █","███"],
    "7": ["███","  █","  █","  █","  █"],
    "8": ["███","█ █","███","█ █","███"],
    "9": ["███","█ █","███","  █","███"],
    ":": ["   "," █ ","   "," █ ","   "],
}

SOURCE = """def demo():
    pass

# terminal quine-clock style demo
"""

def render_clock(t):
    rows = ["", "", "", "", ""]
    for ch in t:
        glyph = DIGITS[ch]
        for i in range(5):
            rows[i] += glyph[i] + "  "
    return "\n".join(rows)

while True:
    now = datetime.now().strftime("%H:%M:%S")
    print("\x1b[H\x1b[2J", end="")  # clear screen
    print(SOURCE)
    print(render_clock(now))
    time.sleep(0.2)

    
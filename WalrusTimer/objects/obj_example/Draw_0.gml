/// @desc Draw the text

draw_set_font(fnt_example)
draw_text(x, y, "The timer has " + string(timer_get(timer)) + " frames left.")
draw_set_color(c_white)
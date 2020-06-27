/// @desc Draw the text

draw_set_font(fnt_example);
draw_set_color($21C7FF);
draw_text(x, y, "The timer has " + string(timer_get(timer)) + " frames left.");
draw_set_color(c_white);
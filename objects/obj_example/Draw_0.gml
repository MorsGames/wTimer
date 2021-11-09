/// @desc Draw the text

draw_set_font(fnt_example);
draw_set_color($21C7FF);

var _timer_get = timer_get(test_timer)
var _remaining_duration_text = is_method(_timer_get) ? "[trigger]" : string(_timer_get);
var _total_duration_text = string(timer_get_time(test_timer));
var _type_text = ((timer_get_type(test_timer) == 1) ? "milliseconds" : "frames");

draw_text(x, y, "The timer has " + _remaining_duration_text + " out of " + _total_duration_text + " " + _type_text + " left.");

var _pause_text = timer_get_paused(test_timer) ? "Unpause" : "Pause";
var _slow_down_text = (timer_get_multiplier(test_timer) == 1) ? "Slow down" : "Speed up";

draw_text(x, y + 128, "Space: " + _pause_text + " the timer.\nS: " + _slow_down_text + " the timer.\nD: Destroy the timer.\nF: Deactivate the object for 60 frames.\nC: Change the timer duration to 60.");

draw_set_color(c_white);
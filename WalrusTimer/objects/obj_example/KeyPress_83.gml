/// @desc Slow down the current timer.
if (timer_get_multiplier(test_timer) == 1) {
	timer_set_multiplier(test_timer, 0.1)
}
else {
	timer_set_multiplier(test_timer, 1)
}
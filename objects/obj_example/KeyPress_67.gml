/// @desc Change the current timer's remaining duration if the timer type isn't a trigger

if (timer_get_type(test_timer) != timer_type.trigger)
	timer_change(test_timer, 60)
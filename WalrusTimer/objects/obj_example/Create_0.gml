/// @desc The example object

callback1 = function() {
	show_message("The next timer will be completed in 200 frames.");
	test_timer = timer(callback2, 200);
}

callback2 = function() {
	show_message("The next timer will run in real time, independently from the frame rate.");
	test_timer = timer_ms(callback3, 2000);
}

callback3 = function() {
	show_message("The next timer isn't exactly a timer. It only completes once a function returns true. Right click anywhere to make it return true.");
	test_timer = timer_trigger(callback4, function(){return mouse_check_button_pressed(mb_right);});
}

callback4 = function() {
	show_message("Did you notice that we can use inline functions? The next timer will repeat forever at the same interval.");
	test_timer = timer(callback5, 120, true);
}

callback5 = function() {
	show_message("I told you it would repeat!");
}

test_timer = timer(callback1, 120);
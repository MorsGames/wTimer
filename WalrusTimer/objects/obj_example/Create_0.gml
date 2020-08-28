/// @desc The example object

callback1 = function() {
	show_message("You can press Space to pause the current timer, or press D to destroy it. Try it.");
	timer = timer_set(function(){show_message("You can do inline functions too.");timer = timer_set(callback2, 60, true);}, 200);
}
callback2 = function() {
	show_message("This timer will repeat forever at the same interval. You can start another timer if you press Enter.");
}
timer = timer_set(callback1, 300);
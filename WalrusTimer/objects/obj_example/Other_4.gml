/// @desc The example object

// I'm putting the logic into Room Start instead of Create, since the timers can't be used before whole timer system gets initialized.
// You should not have an issue with this unless you're trying to use the timers the same frame the system gets initialized. 
// Unfortunately putting the variable initializations directly into the script gave me some issues when the game restarts, so we have to live with this.

callback = function() {
	show_message("You can press Space to destroy the current timer. Try it.")
	timer = timer_set(function(){show_message("You can do inline functions too.");timer = timer_set(callback, 300)}, 600)
}
timer = timer_set(callback, 300)
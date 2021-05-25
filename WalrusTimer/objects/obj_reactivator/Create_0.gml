/// @desc An object that will reactivate the main example one in 60 frames

// The method our timer will call
reactivate = function() {
	instance_activate_object(obj_example);
	instance_destroy();
}

// Start the timer
timer(reactivate, 60);
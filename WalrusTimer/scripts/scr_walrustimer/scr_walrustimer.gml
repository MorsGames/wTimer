// WalrusTimer by Mors
// Version v1.0
// Licensed under GNU LGPLv3. Please give credit if used though, otherwise I will cry.

/// @func timer_set(callback, frames)
/// @argument {function} callback The callback to invoke.
/// @argument {number} frames How long the wait will be for the timer to execute the callback function.
/// @argument {bool} persistent[OPTIONAL] If the timer will be destroyed between rooms or not. False by default.
/// @argument {anything} argument[OPTIONAL] The argument that can be used with the function. Optional.
/// @returns {number} The ID corresponding to the timer. Optional.
function timer_set(_callback, _frames) {
	var _argument = noone;
	var _persistent = false;
	
	if (argument_count > 3)
		_persistent = argument[2]
	if (argument_count == 4)
		_argument = argument[3]
		
	ds_list_add(global.__timer_list, {
		index: global.__timer_index,
		cback: _callback,
		value: _frames,
		pers: _persistent,
		arg: _argument
	});
	
	return global.__timer_index++;
}

/// @func timer_destroy(timer)
/// @desc Stops and destroys a timer. Does not need to be called manually after a timer's time runs out.
/// @argument {number} _timer The index of the timer to destroy.
/// @returns {bool} Whether if the timer was successfully removed or not.
function timer_destroy(_timer) {
	for (i = 0; i < ds_list_size(global.__timer_list); i++) {
		var _result = global.__timer_list[| i]
		if (_result.index == _timer) {
            delete _result
			ds_list_delete(global.__timer_list, i);	
			return true;
		}
	}
	return false;
}

/// @func timer_get(timer)
/// @desc Returns how much time the timer has left, in frames. Returns -1 if the timer doesn't exist.
/// @argument {number} _timer The index of the timer to destroy.
/// @returns {number} How much time the timer has left, in frames.
function timer_get(_timer) {
	for (i = 0; i < ds_list_size(global.__timer_list); i++) {
		var _result = global.__timer_list[| i]
		if (_result.index == _timer) {
            return _result.value
		}
	}
	return -1;
}

/// @func timer_system_init()
/// @desc Must be called before using any of the other methods here.
function timer_system_init() {
	global.__timer_list = ds_list_create();
	global.__timer_index = 0;
}

/// @func timer_system_update()
/// @desc Must be called every single frame for the timers to work.
function timer_system_update() {
	for (var i = 0; i < ds_list_size(global.__timer_list); i++) {
		var _result = global.__timer_list[| i]
		if (_result.value <= 0) {
			if (_result.arg != noone)
				_result.cback(_result.arg)
			else
				_result.cback()
			delete global.__timer_list[| i]
			ds_list_delete(global.__timer_list, i);	
			i--
		}
		else {
			_result.value--
		}
	}
}

/// @func timer_system_room_end()
/// @desc Must be called at the end of every room.
function timer_system_room_end() {
	for (var i = 0; i < ds_list_size(global.__timer_list); i++) {
		var _timer = global.__timer_list[| i]
		if (_timer.value <= 0) {
			if (!_timer.pers)
				delete global.__timer_list[| i]
				ds_list_delete(global.__timer_list, i);	
			i--
		}
		else {
			_timer.value--
		}
	}
}
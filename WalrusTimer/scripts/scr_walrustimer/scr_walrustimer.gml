// WalrusTimer by Mors
// http://www.mors-games.com/
// Licensed under MPL 2.0. Please give credit if used, otherwise I will be very sad.

#macro __WALRUSTIMER_VERSION "1.1.0"

show_debug_message("WalrusTimer v" + __WALRUSTIMER_VERSION + " by Mors");

global.__timer_list = ds_list_create();
global.__timer_index = 0;

/// @func timer_set(callback, frames, repeat[OPTIONAL], persistent[OPTIONAL], argument[OPTIONAL])
/// @argument {function} callback The callback to invoke.
/// @argument {number} frames How long the wait will be for the timer to execute the callback function.
/// @argument {bool} repeat[OPTIONAL] If the timer will repeat after being completed or will be destroyed. False by default.
/// @argument {bool} persistent[OPTIONAL] If the timer will be destroyed between rooms or not. False by default.
/// @argument {anything} argument[OPTIONAL] The argument that can be used with the function. Optional.
/// @returns {number} The ID corresponding to the timer. Optional.
function timer_set(_callback, _frames) {
	var _argument = noone;
	var _persistent = false;
	var _repeat = false;
	if (argument_count > 2)
	    _repeat = argument[2];
	if (argument_count > 3)
		_persistent = argument[3];
	if (argument_count > 4)
		_argument = argument[4];
	ds_list_add(global.__timer_list, {
		in: global.__timer_index,
		cb: _callback,
		iv: _frames,
		fv: _frames,
		rp: _repeat,
		pr: _persistent,
		ar: _argument,
		ps: 0
	});
	
	return global.__timer_index++;
}

/// @func timer_destroy(timer)
/// @desc Stops and destroys a timer. Does not need to be called manually after a timer's time runs out.
/// @argument {number} timer The index of the timer to destroy.
/// @returns {bool} Whether if the timer was successfully removed or not.
function timer_destroy(_timer) {
	for (var i = 0; i < ds_list_size(global.__timer_list); i++) {
		var _result = global.__timer_list[| i];
		if (_result.in == _timer) {
            delete _result;
			ds_list_delete(global.__timer_list, i);	
			return true;
		}
	}
	return false;
}

/// @func timer_get(timer)
/// @desc Returns how much time the timer has left, in frames. Returns -1 if the timer doesn't exist.
/// @argument {number} timer The index of the timer to destroy.
/// @returns {number} How much time the timer has left, in frames.
function timer_get(_timer) {
	for (var i = 0; i < ds_list_size(global.__timer_list); i++) {
		var _result = global.__timer_list[| i];
		if (_result.in == _timer) {
            return _result.fv;
		}
	}
	return -1;
}

/// @func timer_set_pause(timer, pause)
/// @desc Pauses a timer.
/// @argument {number} timer The index of the timer to pause.
/// @argument {bool} timer If the timer should be paused or resumed.
/// @returns {bool} Whether if the timer was successfully paused or not.
function timer_set_pause(_timer, _pause) {
	for (var i = 0; i < ds_list_size(global.__timer_list); i++) {
		var _result = global.__timer_list[| i]
		if (_result.in == _timer) {
            _result.ps = _pause;
			return true;
		}
	}
	return false;
}

/// @func timer_get_pause(timer)
/// @desc Gets whether if a timer is paused or not.
/// @argument {number} timer The index of the timer.
/// @returns {bool} Whether if the timer is paused or not. Returns -1 if the timer doesn't exist.
function timer_get_pause(_timer) {
	for (var i = 0; i < ds_list_size(global.__timer_list); i++) {
		var _result = global.__timer_list[| i]
		if (_result.in == _timer) {
            return _result.ps;
		}
	}
	return -1;
}

/// @func timer_system_update(tick_rate[OPTIONAL])
/// @desc Must be called every single frame for the timers to work.
/// @argument {number} tick_rate[OPTIONAL] The global tick rate for the timers. Useful if you want to use delta time for your game.
function timer_system_update() {
	var _tick_rate = 1;
	if (argument_count > 0)
	    _tick_rate = argument[0];
	for (var i = 0; i < ds_list_size(global.__timer_list); i++) {
		var _result = global.__timer_list[| i];
		if (_result.fv <= 0) {
			if (_result.ar != noone)
				_result.cb(_result.ar);
			else
				_result.cb();
			if (_result.rp) {
				_result.fv = _result.iv;
			}
			else {
				delete _result;
				ds_list_delete(global.__timer_list, i);
				i--;
			}
		}
		else if (!_result.ps) {
			_result.fv -= _tick_rate;
		}
	}
}

/// @func timer_system_room_end()
/// @desc Must be called at the end of every room.
function timer_system_room_end() {
	for (var i = 0; i < ds_list_size(global.__timer_list); i++) {
		var _result = global.__timer_list[| i];
		if (_result.fv <= 0) {
			if (!_result.pr)
				delete _result;
				ds_list_delete(global.__timer_list, i);	
			i--;
		}
		else {
			_result.fv--;
		}
	}
}
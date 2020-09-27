// WalrusTimer by Mors
// http://www.mors-games.com/
// Licensed under MPL 2.0. Please give credit if used, otherwise I will be very sad.

#macro __WALRUSTIMER_VERSION "1.3.0"

show_debug_message("WalrusTimer v" + __WALRUSTIMER_VERSION + " by Mors");

global.__timer_list = ds_list_create();
global.__timer_index = 0;
global._global.__tick_rate = 1;

/// @func timer_set(callback, value, repeat[OPTIONAL], persistent[OPTIONAL], argument[OPTIONAL])
/// @argument {function} callback The callback to invoke.
/// @argument {number} value How long the wait will be for the timer to execute the callback function, either in frames or milliseconds depending on if the system is running at frame rate independent mode or not.
/// @argument {bool} repeat[OPTIONAL] If the timer will repeat after being completed or will be destroyed. False by default.
/// @argument {anything} arguments...[OPTIONAL] Arguments that can be used with the function. You can have a maximum of 16. Optional.
/// @returns {number} The ID corresponding to the timer.
function timer_set(_callback, _value) {
	var _repeat = false;
	var _arguments = noone;
	if (argument_count > 2)
	    _repeat = argument[2];
	if (argument_count > 3) {
		for (var i = 3; i < argument_count; i++) {
			_arguments[i-3] = argument[i]
		}
	}
		
	ds_list_add(global.__timer_list, {
		in: global.__timer_index,
		ci: id,
		cb: _callback,
		iv: _value,
		fv: _value,
		rp: _repeat,
		ar: _arguments,
		ct: current_time,
		et: 0,
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

/// @func timer_pause(timer, pause[OPTIONAL])
/// @desc Pauses a timer.
/// @argument {number} timer The index of the timer to pause.
/// @argument {bool} pause[OPTIONAL] If the timer should be paused or resumed. When not used, the timer just gets toggled.
/// @returns {bool} Whether if the timer was successfully paused or not.
function timer_pause(_timer) {
	for (var i = 0; i < ds_list_size(global.__timer_list); i++) {
		var _result = global.__timer_list[| i]
		if (_result.in == _timer) {
			if (argument_count > 1) {
				_result.ps = argument[1];
			}
			else {
				_result.ps = !_result.ps;
			}
			if (_result.ps) {
				_result.et -= current_time;
			}
			else  {
				_result.et += current_time;
			}
			return true;
		}
	}
	return false;
}

/// @func timer_change(timer, value, change_repeat_time[OPTIONAL])
/// @desc Changes the current remaining time of the timer, or the milliseconds it takes for timer to complete if the system is running at frame rate independent mode.
/// @argument {number} timer The index of the timer to pause.
/// @argument {number} value The new remaining time for the timer, either in frames or milliseconds depending on if the system is running at frame rate independent mode or not.
/// @argument {number} change_repeat_time[OPTIONAL] When true, only the time used for the future repeats of the timer is changed.
/// @returns {bool} Whether if the timer's remaining time was successfully changed or not.
function timer_change(_timer, _value) {
	var _change_repeat_time = false;
	if (argument_count > 2)
	    _change_repeat_time = argument[2];
	for (var i = 0; i < ds_list_size(global.__timer_list); i++) {
		var _result = global.__timer_list[| i]
		if (_result.in == _timer) {
			if (_change_repeat_time) {
				_result.iv = _value;
			}
			else {
				_result.fv = _value;
			}
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

/// @func timer_system_set_tickrate(tick_rate)
/// @desc Changes the tick rate of the timer system. If you set it to -1 the timer will run independently from the frame rate, and you will need to use milliseconds instead of frames for the timer durations. 
/// @argument {number} tick_rate The global tick rate for the timers.
function timer_system_set_tickrate(_tick_rate) {
	global.__tick_rate = _tick_rate;
}

/// @func timer_system_update()
/// @desc Must be called every single frame for the timers to work.
function timer_system_update() {
	for (var i = 0; i < ds_list_size(global.__timer_list); i++) {
		var _result = global.__timer_list[| i];
		if (_result.fv <= 0 || (global.__tick_rate < 0 && current_time - _result.ct >= _result.fv+_result.et && !_result.ps)) {
			if (instance_exists(_result.ci)) {
				var _a = _result.ar;
				var _c = _result.cb;
				var _len = is_array(_a) ? array_length(_a) : -1;
				with (_result.ci) {
					// I had no other way of achieving this...
					switch (_len) {
					    case 1:  _c(_a[0]); break;
					    case 2:  _c(_a[0], _a[1]); break;
					    case 3:  _c(_a[0], _a[1], _a[2]); break;
					    case 4:  _c(_a[0], _a[1], _a[2], _a[3]); break;
					    case 5:  _c(_a[0], _a[1], _a[2], _a[3], _a[4]); break;
					    case 6:  _c(_a[0], _a[1], _a[2], _a[3], _a[4], _a[5]); break;
					    case 7:  _c(_a[0], _a[1], _a[2], _a[3], _a[4], _a[5], _a[6]); break;
					    case 8:  _c(_a[0], _a[1], _a[2], _a[3], _a[4], _a[5], _a[6], _a[7]); break;
					    case 9:  _c(_a[0], _a[1], _a[2], _a[3], _a[4], _a[5], _a[6], _a[7], _a[8]); break;
					    case 10: _c(_a[0], _a[1], _a[2], _a[3], _a[4], _a[5], _a[6], _a[7], _a[8], _a[9]); break;
					    case 11: _c(_a[0], _a[1], _a[2], _a[3], _a[4], _a[5], _a[6], _a[7], _a[8], _a[9], _a[10]); break;
					    case 12: _c(_a[0], _a[1], _a[2], _a[3], _a[4], _a[5], _a[6], _a[7], _a[8], _a[9], _a[10], _a[11]); break;
					    case 13: _c(_a[0], _a[1], _a[2], _a[3], _a[4], _a[5], _a[6], _a[7], _a[8], _a[9], _a[10], _a[11], _a[12]); break;
					    case 14: _c(_a[0], _a[1], _a[2], _a[3], _a[4], _a[5], _a[6], _a[7], _a[8], _a[9], _a[10], _a[11], _a[12], _a[13]); break;
					    case 15: _c(_a[0], _a[1], _a[2], _a[3], _a[4], _a[5], _a[6], _a[7], _a[8], _a[9], _a[10], _a[11], _a[12], _a[13], _a[14]); break;
					    case 16: _c(_a[0], _a[1], _a[2], _a[3], _a[4], _a[5], _a[6], _a[7], _a[8], _a[9], _a[10], _a[11], _a[12], _a[13], _a[14], _a[15]); break;
					    default: _c(); break;
					}
				}
			}
			if (instance_exists(_result.ci) && _result.rp) {
				_result.fv = _result.iv;
				_result.ct = current_time;
			}
			else {
				delete _result;
				ds_list_delete(global.__timer_list, i);
				i--;
			}
		}
		else if (!_result.ps && global.__tick_rate > 0) {
			_result.fv -= global.__tick_rate;
		}
	}
}

/// @func timer_system_room_end()
/// @desc Must be called at the end of every room.
function timer_system_room_end() {
	for (var i = 0; i < ds_list_size(global.__timer_list); i++) {
		var _result = global.__timer_list[| i];
		if (_result.fv <= 0) {
			if (instance_exists(_result.ci) && !_result.ci.persistent)
				delete _result;
				ds_list_delete(global.__timer_list, i);	
			i--;
		}
		else {
			_result.fv--;
		}
	}
}
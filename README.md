# WalrusTimer v1.3.1

**WalrusTimer** is a replacement library for **GameMaker Studio 2.3+**'s built-in alarms.

[itch.io](https://mors-games.itch.io/WalrusTimer) | [YoYo Marketplace](https://marketplace.yoyogames.com/assets/9388/walrustimer) | [Discord Server](https://discord.gg/4jgSARF)

With this library, you can create timers that run a custom method you give it after a certain number of frames. This is very similar to GameMaker's built-in alarms, but instead of relying on separate actions, with this library, you can just use your own methods, meaning you can declare timers and what they do in a single script, or even a single line if you so choose!

The usage of this library is very similar to Javascript's "setInterval()" and "setTimeout()" methods, so if you're familiar with Javascript this will also feel very familiar.


## Basic Usage

```gml
callback1 = function() {
	show_message("Pretty cool, huh?");
}
callback2 = function() {
	show_message("This timer will repeat forever at the same interval.");
}
timer_set(callback1, 300);
timer_set(callback2, 60, true);
timer_set(function(){show_message("You can do inline functions too.");}, 200);
```


## Details
This library comes with 10 methods.
- timer_set(callback, value, repeat[OPTIONAL], arguments...[OPTIONAL])
- timer_destroy(timer)
- timer_get(timer)
- timer_change(timer, value, change_repeat_time[OPTIONAL])
- timer_pause(timer, pause[OPTIONAL])
- timer_get_paused(timer)
- timer_system_update(tick_rate)
- timer_system_room_end()
- timer_system_set_tickrate(tick_rate)
- timer_system_get_tickrate()

This library is only tested on Windows and HTML5 platforms, but it should also work on other platforms as well. It also comes with an example project that will teach you the basics.

The entirety of this project is licensed under **MPL 2.0**, so please give me credit if you end up using it.

## Changelog
v1.3.1 (02/10/2020):
- Fixed a minor issue that would result with the library not working at all.
- Added "timer_system_get_tickrate".
- Renamed "timer_get_pause" to "timer_get_paused".
- Minor optimizations.
- Minor reformatting.

v1.3.0 (28/09/2020):
- Renamed "timer_set_pause" to "timer_pause".
- Added "timer_change".
- Added "timer_system_set_tickrate".
- Made it so if you set the tick rate to -1 the timer system runs independently from the frame rate, using milliseconds instead of frames. 
- Fixed a crash that happened if a room ended with a persistent timer while the instance didn't exist.

v1.2.0 (28/08/2020):
- Added support for up to 16 arguments instead of 1.
- The functions will now run in the instance the timer was created in.
- If the instance cannot be found by the time the timer ends, the timer will get destroyed without running any code.
- You don't have to manually declare timers as persistent anymore, it now depends on the instance running the timer.
- Slightly updated the example.

v1.1.0 (27/06/2020):
- Added "timer_set_pause" and "timer_get_pause" methods.
- Added the "repeat" argument to "timer_set". You can now use the timers the same way you'd use Javascript's "setInterval()".
- Added support for custom tick rates, allowing the use of timers with projects that utilize delta time.
- Removed "timer_system_init".
- Made the code more consistent.
- Made the example look fancier.
- Rewrote the description.
- Changed the license to MPL 2.0.

v1.0.0 (15/06/2020):
- Initial release.

If you have any questions, you can ask them on this project's [itch.io page](https://mors-games.itch.io/WalrusTimer) or at my [Discord Server](https://discord.gg/4jgSARF).

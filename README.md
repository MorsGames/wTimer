# wTimer v2.1.2

**wTimer** is a library that offers a more robust alternative for **GameMaker Studio 2.3**'s built-in alarms, alongside some extra functions.

[API Reference](https://github.com/MorsGames/wTimer/wiki) | [itch.io](https://mors-games.itch.io/wTimer)

With this library, you can create timers that run a specific function after a certain amount of time. This is very similar to GameMaker's built-in alarms, but instead of relying on separate actions, you can just use your own methods, meaning you can declare timers and what they do in a single script, or even a single line if you so choose!

The usage of this library is very similar to Javascript's "setInterval()" and "setTimeout()" methods, so if you're familiar with those then you should feel right at home.

This library was only tested on Windows, HTML5, and GXC targets, but it should work on other platforms as well. It also comes with an example project that will show you the basics.

Since I made this library primarily for my own personal projects, I will keep updating it on a regular basis.

This library is made by **Mors** ([Website](http://mors-games.com) | [Patreon](https://www.patreon.com/MorsGames)).


## Basic Usage

```gml
callback = function() {
	show_message("Pretty cool, huh?");
}
timer(callback, 300);

timer(function(){show_message("Forever repeating timer.");}, 60, true);
```

To learn about how to use the individual functions please give the [API Reference](https://github.com/MorsGames/wTimer/wiki) a look.


## License
This library is licensed under **MPL 2.0**. You can learn more about it [here](https://www.mozilla.org/en-US/MPL/2.0/FAQ/).

If you want to use this library under a different license, get in contact with me.


## Changelog
v2.1.2 (09/11/2021):
- Rebranded the library.
- Added the example project to the itch.io page as a playable HTML5 build.
- Made use of GameMaker's optional arguments when applicable.
- Fixed minor errors in the documentation and comments.

v2.1.1 (25/05/2021):
- Added a workaround for an issue that seems like a GameMaker bug.

v2.1.0 (25/05/2021):
- Added "timer_destroy_object".
- Added "timer_set_paused_object".
- Added "timer_set_multiplier_object".
- Made it so that the timers now freeze when the instance they are assigned to is deactivated.
- Updated the example to showcase how the timers now work properly with deactivated instances.
- Fixed an issue with the "wait" function where it wouldn't work properly.
- Made changes to the documentation and the comments.

v2.0.0 (12/03/2021):
- Split "timer_set" into "timer" and "timer_ms", so it's now possible to use both real-time and frame-based timers together.
- Added "timer_trigger".
- Added "timer_get_time".
- Added "timer_get_type".
- Added "timer_set_multiplier".
- Added "timer_get_multiplier".
- Added "wait".
- Added a new global variable called "current_frames".
- Renamed "timer_pause" to "timer_set_paused" for better consistency.
- Changed some of the argument names.
- Fixed some mistakes with the comments, and tweaked them in general.
- Adjusted the code a bit.
- Fixed a few issues with timers not getting destroyed properly when a room ends.
- Added the [API Reference](https://github.com/MorsGames/wTimer/wiki).

v1.3.1 (02/10/2020):
- Fixed a minor issue that would result in the library not working at all.
- Added "timer_system_get_tickrate".
- Renamed "timer_get_pause" to "timer_get_paused".
- Done some minor optimizations.
- Done some minor reformatting.

v1.3.0 (28/09/2020):
- Renamed "timer_set_pause" to "timer_pause".
- Added "timer_change".
- Added "timer_system_set_tickrate".
- Made it so if you set the tick rate to -1 the timer system runs independently from the frame rate, using milliseconds instead of frames. 
- Fixed a crash that would happen if a room ended with a persistent timer while the instance didn't exist.

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

If you have any questions, you can ask them on this project's [itch.io page](https://mors-games.itch.io/WalrusTimer) or create an issue in this repository.

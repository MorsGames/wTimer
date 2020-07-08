# WalrusTimer v1.1.0

**WalrusTimer** is a replacement library for **GameMaker Studio 2.3**'s built-in alarms.

[Download from itch.io!](https://mors-games.itch.io/WalrusTimer)

With this library you can create timers that run a custom method you give it after a certain number of frames. This is very similar to GameMaker's built-in alarms, but instead of relying on separate actions, with this library you can just use your own methods, meaning you can declare timers and what they do in a single script, or even a single line if you so choose!

The usage of this library is very similar to Javascript's "setInterval()" and "setTimeout()" methods, so if you're familiar with Javascript this will also feel very familiar.

---

This library comes with 6 methods.
- timer_set(callback, frames, repeat[OPTIONAL], persistent[OPTIONAL], argument[OPTIONAL])
- timer_destroy(timer)
- timer_get(timer)
- timer_set_pause(timer, pause)
- timer_get_pause(timer)
- timer_system_update(tick_rate[OPTIONAL])
- timer_system_room_end()

This library is only tested on Windows, and currently has some issues with HTML5. If you have any idea what could be the cause of those issues please let me know. It also comes with an example project that will teach you the basics.

The entirety of this project is licensed under **MPL 2.0**. Please give me credit if you end up using this library, otherwise I will be very sad.

---

## Changelog
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
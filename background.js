// Generated by CoffeeScript 1.3.3
(function() {
  var click_listener, default_minutes, display_time, handle_display_time, pomodorro_running, schedule_start, set_text, should_display_time, start_pomodorro, time;

  pomodorro_running = false;

  set_text = function(text) {
    return chrome.browserAction.setBadgeText({
      text: "" + text
    });
  };

  default_minutes = 25;

  time = default_minutes * 60;

  start_pomodorro = function() {
    pomodorro_running = true;
    return time = default_minutes * 60;
  };

  display_time = function(seconds) {
    var time_to_show;
    time_to_show = seconds === 0 ? "OK" : seconds / 60;
    return set_text(time_to_show);
  };

  should_display_time = function(seconds) {
    return (seconds % 60) === 0;
  };

  handle_display_time = function(seconds) {
    if (should_display_time(seconds)) {
      return display_time(seconds);
    }
  };

  schedule_start = function() {
    var notif;
    handle_display_time(time);
    time -= 1;
    if (time < 0) {
      pomodorro_running = false;
      notif = webkitNotifications.createNotification("icon_16.png", "Pomodorro finished", "Congrats!");
      return notif.show();
    } else {
      return window.setTimeout(schedule_start, 1000);
    }
  };

  click_listener = function() {
    if (!pomodorro_running) {
      start_pomodorro();
      return schedule_start();
    }
  };

  set_text("");

  chrome.browserAction.onClicked.addListener(click_listener);

}).call(this);

pomodorro_running = false

default_minutes = 25
time = default_minutes * 60

start_pomodorro = ->
  pomodorro_running = true
  time = default_minutes * 60

display_time = (seconds) ->
  time_to_show = seconds / 60
  chrome.browserAction.setBadgeText({text: "#{time_to_show}"})

should_display_time = (seconds) ->
  (seconds % 60) == 0

handle_display_time = (seconds) ->
  display_time(seconds) if should_display_time(seconds)

click_listener = ->
  if not pomodorro_running
    start_pomodorro()
  handle_display_time(time)
  time -= 1
  if time < 0
    pomodorro_running = false
    notif = webkitNotifications.createNotification("icon.png", "Pomodorro finished", "Congrats!")
    notif.show()
  else
    window.setTimeout(click_listener, 1000)

chrome.browserAction.onClicked.addListener(click_listener)

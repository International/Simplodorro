pomodorro_running = false

set_text = (text) ->
  chrome.browserAction.setBadgeText({text: "#{text}"})

default_minutes = 25
time = default_minutes * 60

start_pomodorro = ->
  pomodorro_running = true
  time = default_minutes * 60

display_time = (seconds) ->
  time_to_show = if seconds == 0 then "OK" else seconds / 60
  set_text(time_to_show)

should_display_time = (seconds) ->
  (seconds % 60) == 0

handle_display_time = (seconds) ->
  display_time(seconds) if should_display_time(seconds)

schedule_start = ->
  handle_display_time(time)
  time -= 1
  if time < 0
    pomodorro_running = false
    notif = webkitNotifications.createNotification("icon_16.png", "Pomodorro finished", "Congrats!")
    notif.show()
  else
    window.setTimeout(schedule_start, 1000)

click_listener = ->
  if not pomodorro_running
    start_pomodorro()
    schedule_start()

set_text("")
chrome.browserAction.onClicked.addListener(click_listener)

pomodorro_running = false

default_minutes = 2
time = default_minutes * 60

start_pomodorro = ->
  pomodorro_running = true
  time = default_minutes * 60

schedule_action = ->

click_listener = ->
  if not pomodorro_running
    start_pomodorro()
  chrome.browserAction.setBadgeText({text: "#{time}"})
  time -= 1
  if time < 0
    pomodorro_running = false
    notif = webkitNotifications.createNotification(null, "Pomodorro finished", "Congrats!")
    notif.show()
  else
    window.setTimeout(click_listener, 1000)

chrome.browserAction.onClicked.addListener(click_listener)

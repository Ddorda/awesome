-- Clock + Calendar

-- Code below converted to widget from Calender35 (https://github.com/cdump/awesome-calendar)
-- it is not mine, and I don't take any responsibility for this nice piece of code.
-- my specific changes can be found @ https://github.com/Ddorda/awesome-calendar

local clockal = {}
clockal.calendar = {}
clockal.current_day_format = '<span color="#ee7777"><b>%s</b></span>'
clockal.clock_widget = wibox.widget.textclock()

clockal.displayMonth = function(month, year, weekStart)
  local t,wkSt=os.time{year=year, month=month+1, day=0},weekStart or 1
  local d=os.date("*t",t)
  local mthDays,stDay=d.day,(d.wday-d.day-wkSt+1)%7

  local lines = " "

  for x=0,6 do
    lines = lines .. os.date(" <b>%a</b> ",os.time{year=2006,month=1,day=x+wkSt})
  end

  lines = lines .. "\n"

  local writeLine = 1
  while writeLine < (stDay + 1) do
    --lines = lines .. "    "
    lines = lines .. "     "
    writeLine = writeLine + 1
  end

  for d=1,mthDays do
    local x = d
    local t = os.time{year=year,month=month,day=d}
    if writeLine == 8 then
      writeLine = 1
      lines = lines .. "\n"
    end
    if os.date("%Y-%m-%d") == os.date("%Y-%m-%d", t) then
      x = string.format(clockal.current_day_format, d)
    end
    if (#(tostring(d)) == 1) then
      x = " " .. x
    end
    lines = lines .. "   " .. x
    writeLine = writeLine + 1
  end
  local header = "<b><i>" .. os.date("%B, %Y", os.time{year=year,month=month,day=1}) .. "</i></b>\n"

  return header .. "\n" .. lines
end

clockal.switchNaughtyMonth = function(switchMonths)
  if (#clockal.calendar < 3) then return end
  local swMonths = switchMonths or 1
  clockal.calendar[1] = clockal.calendar[1] + swMonths

  clockal.calendar_new = { clockal.calendar[1], clockal.calendar[2],
  naughty.notify({
    text = string.format('<span font_desc="%s">%s</span>', "monospace", clockal.displayMonth(clockal.calendar[1], clockal.calendar[2])),
    timeout = 0,
    hover_timeout = 0.5,
    screen = mouse.screen,
    replaces_id = clockal.calendar[3].id
  })}
  clockal.calendar = clockal.calendar_new
end

clockal.switchNaughtyGoToToday = function()
  if (#clockal.calendar < 3) then return end
  local swMonths = switchMonths or 1
  clockal.calendar[1] = os.date("*t").month
  clockal.calendar[2] = os.date("*t").year
  clockal.displayMonth(0)
end

clockal.addCalendarToWidget = function(mywidget)
  mywidget:connect_signal('mouse::enter', function ()
    local month, year = os.date('%m'), os.date('%Y')
    clockal.calendar = { month, year,
      naughty.notify({
        text = string.format('<span font_desc="%s">%s</span>', "monospace", clockal.displayMonth(month, year)),
        timeout = 0,
        hover_timeout = 0.5,
        screen = mouse.screen
      })
    }
  end)
  mywidget:connect_signal('mouse::leave', function () naughty.destroy(clockal.calendar[3]) end)

  mywidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function()
      clockal.switchNaughtyMonth(-1)
    end),
    awful.button({ }, 2, switchNaughtyGoToToday),
    awful.button({ }, 3, function()
      clockal.switchNaughtyMonth(1)
    end),
    awful.button({ }, 4, function()
      clockal.switchNaughtyMonth(-1)
    end),
    awful.button({ }, 5, function()
      clockal.switchNaughtyMonth(1)
    end),
    awful.button({ 'Shift' }, 1, function()
      clockal.switchNaughtyMonth(-12)
    end),
    awful.button({ 'Shift' }, 3, function()
      clockal.switchNaughtyMonth(12)
    end),
    awful.button({ 'Shift' }, 4, function()
      clockal.switchNaughtyMonth(-12)
    end),
    awful.button({ 'Shift' }, 5, function()
      clockal.switchNaughtyMonth(12)
    end)
  ))
end

clockal._init = function()
  clockal.addCalendarToWidget(clockal.clock_widget)
end

return clockal
-- DO NOT MODIFY

--
-- Widgets
--

-- Init widgets
for k,v in pairs(config.widgets.libs) do
  if countSet(config.widgets.enable) == 0 or config.widgets.enable[k] then
    v._init()
  end
end

-- init widgets layout
for k,v in pairs(config.widgets.layouts.right) do
  config.widgets.layouts.right[k] = loadstring("return " .. v)()
end
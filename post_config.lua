-- DO NOT MODIFY

for k,v in pairs(config.widgets.libs) do

  if config.widgets.enable[k] or countSet(config.widgets.enable) == 0 then
    v._init()
  end
end
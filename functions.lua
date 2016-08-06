-- FILES
function scan_lua_files(dir)
    local files = {}
    local pfile = io.popen(string.format('ls %s/*.lua', dir))
    for line in pfile:lines() do
        table.insert(files, line)
    end
    pfile:close()
    table.sort(files)
    return files
end

-- Set
function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

function countSet(set)
  local count = 0
  for _ in pairs(set) do count = count + 1 end
  return count
end
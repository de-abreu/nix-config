--- @sync entry
local function entry(_, job)
  local cur = cx.active.current
  local idx = tonumber(job.args[1]) - 1
  for _ = #cx.tabs, idx do
    ya.emit("tab_create", { cur.cwd })
    if cur.hovered then
      ya.emit("reveal", { cur.hovered.url })
    end
  end
  ya.emit("tab_switch", { idx })
end

return { entry = entry }
local util = {}

--- Map args across multiple functions with the same signature.
--- Any nonfunctions are ignored.
--- @param funcs table<any, any>|fun(): function  The functions to call
--- @param ... any Arguments to pass to each function.
function util.map(funcs, ...)
  if type(funcs) == "function" then
    for f in funcs() do
      pcall(f, ...)
    end
    return
  end

  if type(funcs) == "table" then
    for k, f in ipairs(funcs) do
      --pcall(f, ...)
      print(k)
    end
  end
end

return util

function string.split(self, delim, plain)
    local ret = {}

    if not self or self == '' then
        return ret
    end

    if not delim or delim == '' then
        for i = 1, #self do
            ret[i] = string.byte(self, i)
        end

        return ret
    end

    local p = 1
    while true do
        local i, j = string.find(self, delim, p, plain)
        if not i then
            break
        end

        table.insert(ret, string.sub(self, p, i - 1))
        p = j + 1
    end

    table.insert(ret, string.sub(self, p))
    return ret
end

--[[
<s>
Parses .env syntax into Lua table
<s>
Example:
```lua
local result = require 'dotenv'.parse 'TEST="test"'

print(result.TEST) -- Prints "test"
```
]]
---@param src string Pass .env syntax
---@return table The variable(s) into table
local function parser(src)
  local tbl = {}

  for _,var in pairs(src:split('\n+')) do
    local linevar = var:split('=')

    local vname = linevar[1]
    local val = linevar[2]

    if val then
      local sepd = var:split(' ')

      if sepd and not val:find '^[\'"].+[\'"]$' then
        val = sepd[1]:split('=')[2]
      end

      if linevar[3] then
        val = table.concat(linevar,'=',2):gsub('%s+$','')
      end

      local noquote = val:gsub('^[\'"]',''):gsub('[\'"]$','')
      tbl[vname] = noquote
    end
  end

 return tbl
end
--[[
<s>
Configure dotenv, put all environment variable(s) in *.env into os.env
]]
---@param path string? The path to *.env
local function config(path)
    path = path or './.env'
    if not path:find '.env$' then
        error 'Must be a .env file!'
    end

    local file = assert(io.open(path,'rb'),'Invalid path: "'..path..'"')
    local data

    if _VERSION >= 'Lua 5.3' then
        data = file:read 'a'; file:close()
    else
        data = file:read '*a'; file:close()
    end

    os.env = parser(data)
end

return {
    config = config,
    parse = parser
}

local env = require "redotenv".load()

for i,v in pairs(env) do
    print("key:",i)
    print("value:",v)
end

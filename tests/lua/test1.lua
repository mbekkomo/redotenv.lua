require "dotenv".config()

for i,v in pairs(os.env) do
    print("key:",i)
    print("value:",v)
end

package = "redotenv.lua"
version = "dev-1"
source = {
   url = "git+https://github.com/UrNightmaree/redotenv.lua.git"
}
description = {
   homepage = "https://github.com/UrNightmaree/redotenv.lua",
   license = "MIT"
}
build = {
   type = "builtin",
   modules = {
      package = "package.lua"
   }
}

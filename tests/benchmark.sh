#!/usr/bin/env bash

case "$1" in
    lua)
        cd lua
        luarocks install $(cat deps.txt) --tree ./lua_modules
        eval "$(luarocks path)"
        hyperfine "lua "{test1.lua,test2.lua} --export-markdown lua-benchmark.md --show-output
        ;;
    luvit)
        cd luvit
        lit install $(cat deps.txt)
        hyperfine "luvit "{test1.lua,test2.lua} --export-markdown luvit-benchmark.md --show-output
        ;;
    *)
        echo "invalid arg: $1"
        exit 1
        ;;
esac

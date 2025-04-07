#! /usr/bin/env lua

local posix = require "posix"

local function parse_arguments()
   local argparse = require "argparse"

   local parser = argparse("set_wallpapers.lua", "Sets random wallpapers to each screen.")
   parser:argument("choice_file", "Path to the file containing all possible wallpapers to use."):args("?")
   parser:flag("-p --pretend", "Only print the commands that would be executed and exit.")

   return parser:parse()
end

local function init_rng()
   math.randomseed(os.time())
end

local function get_monitors()
   local fd = io.popen("hyprctl monitors", "r")
   if not fd then
      error("Could not get monitor list from Hyprland.")
   end

   local contents = fd:read("l")
   local monitors = {}
   while contents ~= nil do
      local a, _, c = string.find(contents, "Monitor ([-a-zA-Z0-9]+)")
      if a  then
         table.insert(monitors, c)
      end
      contents = fd:read("l")
   end
   fd:close()

   return monitors
end

local function get_wallpapers(filepath)
   if not filepath then
      local home = os.getenv("HOME")
      filepath = home .. "/.config/wallpaper_choices.sh"
   end
   local fd = io.popen("bash -c '. ".. filepath .. "; echo -n $wallpaper_dir; printf ':%s' ${choices[@]}'", "r")
   if not fd then
      error("Could not read wallpaper choices.")
   end

   local contents = fd:read("a")
   fd:close()
   local wallpaper_dir = nil
   local choices = {}
   for str in string.gmatch(contents, "([^:]*)") do
      if not wallpaper_dir then
         if str:len() > 0 then
            wallpaper_dir = str
         else
            wallpaper_dir = "."
         end
      else
         table.insert(choices, str)
      end
   end
   return wallpaper_dir, choices
end

-- === Main code === --

local args = parse_arguments()

local monitors = get_monitors()
if #monitors == 0 then
   return
end

local wallpaper_dir, wallpapers = get_wallpapers(args.choice_file)

local command = "swaybg"
local swaybg_args = {}
init_rng()
for index, mon in ipairs(monitors) do
   local num = math.random(1, #wallpapers)
   local wp = wallpapers[num]
   if wp:sub(1, 1) ~= "/" then
      wp = wallpaper_dir .. "/" .. wp
   end
   table.insert(swaybg_args, "-o")
   table.insert(swaybg_args, mon)
   table.insert(swaybg_args, "-m")
   table.insert(swaybg_args, "fill")
   table.insert(swaybg_args, "-i")
   table.insert(swaybg_args, wp)
end

if args.pretend then
   print("swaybg")
   for index, value in ipairs(swaybg_args) do
      print(index .. ": " .. value)
   end
else
   posix.execp("swaybg", swaybg_args)
end


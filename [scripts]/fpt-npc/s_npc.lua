local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")


vRPclient = Tunnel.getInterface("vRP","vRP")


vRPCnpc = Tunnel.getInterface("fpt-npc","fpt-npc")
vRPSnpc = {}
Tunnel.bindInterface("fpt-npc",vRPSnpc)

Proxy.addInterface("fpt-npc",vRPSnpc)

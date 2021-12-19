from pypresence import Presence
import discord
import time
import sys

client = discord.Client()
RPC = Presence("802267074381611018")
RPC.connect()
ctime = time.mktime(time.localtime())
RPC.update(details= "Project: " + sys.argv[1], large_image= "renoise", start= ctime)
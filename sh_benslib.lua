-- Lib of JustBenDev
-- V:0.3
print([[
  ____                 _      _ _      
 |  _ \               | |    (_) |    
 | |_) | ___ _ __  ___| |     _| |__  
 |  _ < / _ \ '_ \/ __| |    | | '_ \ 
 | |_) |  __/ | | \__ \ |____| | |_) |
 |____/ \___|_| |_|___/______|_|_.__/  V:0.3
]])
Bens = {}

if SERVER then
	util.AddNetworkString("BensLib")

	local META = FindMetaTable("Player")
	function META:BPrint(...)
		net.Start("BensLib")
		net.WriteTable({...})
		net.Send(self)
	end
end

function Bens.Round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- Current Color mode
Bens.Color 			= {}
Bens.Color.White 	= Color(255,255,255) 		-- rgb(255,255,255)
Bens.Color.Black 	= Color(0,0,0) 				-- rgb(0,0,0)
Bens.Color.Box		= Color(0,0,0) 				-- rgb(0,0,0)

Bens.Color.Green	= Color(45, 205, 115) 		-- rgb(45, 205, 115)
Bens.Color.Red		= Color(230, 75, 60) 		-- rgb(230, 75, 60)

-- Bens.Color.Orange	= Color(230, 75, 60) 		-- rgb(230, 75, 60)
Bens.Color.Star	= Color(255,200,0)			-- rgb(255,200,0)
-----------------------------------------------------------------------

if CLIENT then
	net.Receive( "BensLib", function( len )
		chat.AddText(unpack(net.ReadTable()))
	end)

	Bens.Ratio 		= ScrW() / 1920

	Bens.Func = {}
	Bens.Func.Darker = function(COLOR,VAL)
		return Color(COLOR["r"]-VAL,COLOR["g"]-VAL,COLOR["b"]-VAL,COLOR["a"])
	end

	Bens.Derma = {}
	local blur = Material("pp/blurscreen")
	function Bens.Derma.DrawBlur(panel, amount)
		local x, y = panel:LocalToScreen(0, 0)
		local scrW, scrH = ScrW(), ScrH()
		surface.SetDrawColor(255, 255, 255)
		surface.SetMaterial(blur)
		for i = 1, 3 do
			blur:SetFloat("$blur", (i / 3) * (amount or 6))
			blur:Recompute()
			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
		end
	end
	Bens.Derma.Btn = function(PARENT,TXT,FONT,DOCK,SIZE,ALIGN,TCOLOR)
		local L = vgui.Create("DButton", PARENT)
		L:SetTextColor(Bens.Color.White)
		if TCOLOR != nil then L:SetTextColor(TCOLOR) end
		if DOCK then L:Dock(DOCK) end
		if FONT then
			L:SetFont(FONT)
		else
			L:SetFont("Rajdhani-Thin-Big")
		end
		if ALIGN != nil then
			L:SetContentAlignment(ALIGN)
		end
		L:SetText(TXT)
		if SIZE == nil then
			L:SizeToContents()
		else
			L:SetSize(SIZE,SIZE)
		end
		return L
	end
	Bens.Derma.BtnImg = function(PARENT,IMG,DOCK,SIZE)
		local L = vgui.Create("DImageButton", PARENT)
		if DOCK then L:Dock(DOCK) end
		if SIZE == nil then
			L:SizeToContents()
		else
			L:SetSize(SIZE,SIZE)
		end
		if IMG != nil then L:SetImage(IMG) end
		return L
	end
	Bens.Derma.FLabel = function(PARENT,TXT,FONT,DOCK,SIZE,ALIGN,TCOLOR)
		local L = vgui.Create("DLabel", PARENT)
		L:SetTextColor(Bens.Color.White)
		if TCOLOR != nil then L:SetTextColor(TCOLOR) end
		if DOCK then L:Dock(DOCK) end
		if FONT then
			L:SetFont(FONT)
		else
			L:SetFont("Rajdhani-Thin-Big")
		end
		if ALIGN != nil then
			L:SetContentAlignment(ALIGN)
		end
		L:SetText(TXT)
		if SIZE == nil then
			L:SizeToContents()
		else
			L:SetSize(SIZE,SIZE)
		end
		return L
	end
	Bens.Derma.Underline = function(s,w,h,COLOR,ALIGN)
		surface.SetFont(s:GetFont())
		local linew,lineh = surface.GetTextSize(s:GetText())
		if ALIGN == 5 then
			draw.RoundedBox(0, w/2-linew/2, s:GetTall()/2+lineh/2-10, linew, 4, COLOR)
		elseif ALIGN == 4 then
			draw.RoundedBox(0, 0, s:GetTall()/2+lineh/2-10, linew, 4, COLOR)
		end
	end
	Bens.Derma.Container = function(PARENT,DOCK,SIZE)
		local C = vgui.Create("Panel", PARENT)
		if DOCK then C:Dock(DOCK) end
		C:SetSize(SIZE,SIZE)
		return C
	end

	Bens.Func.Money = function(MONEY)
		local buffer = ""
		local C = 0
		MONEYTBL = string.Explode("",tostring(MONEY))
		-- for i=1,#MONEYTBL do
		for i=#MONEYTBL,1,-1 do
			buffer = buffer..MONEYTBL[i]
			C = C + 1
			if C == 3 then
				buffer = buffer.." "
				C = 0
			end
		end
		local newbuffer = ""
		for i=#buffer,1,-1 do
			newbuffer = newbuffer..buffer[i]
		end
		return newbuffer
	end
end
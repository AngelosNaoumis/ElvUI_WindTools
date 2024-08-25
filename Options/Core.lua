local W, F, E, L, V, P, G = unpack((select(2, ...)))
local HexToRGB = W.Utilities.Color.HexToRGB
local async = W.Utilities.Async

local gsub = gsub
local pairs = pairs
local strrep = strrep

-- All categories
W.options = {
	item = {
		order = 101,
		name = L["Item"],
		desc = L["Add a lot of QoL features to WoW."],
		icon = W.Media.Icons.item,
		args = {},
	},
	combat = {
		order = 102,
		name = L["Combat"],
		desc = L["Make combat more interesting."],
		icon = W.Media.Icons.combat,
		args = {},
	},
	maps = {
		order = 103,
		name = L["Maps"],
		desc = L["Add some useful features for maps."],
		icon = W.Media.Icons.map,
		args = {},
	},
	quest = {
		order = 104,
		name = L["Quest"],
		desc = L["Make adventure life easier."],
		icon = W.Media.Icons.quest,
		args = {},
	},
	social = {
		order = 105,
		name = L["Social"],
		desc = L["Make some enhancements on chat and friend frames."],
		icon = W.Media.Icons.social,
		args = {},
	},
	announcement = {
		order = 106,
		name = L["Announcement"],
		desc = L["Send something to game automatically."],
		icon = W.Media.Icons.announcement,
		args = {},
	},
	tooltips = {
		order = 107,
		name = L["Tooltips"],
		desc = L["Add some additional information to your tooltips."],
		icon = W.Media.Icons.tooltips,
		args = {},
	},
	unitFrames = {
		order = 108,
		name = L["UnitFrames"],
		desc = L["Add more features to ElvUI UnitFrames."],
		icon = W.Media.Icons.unitFrames,
		args = {},
	},
	skins = {
		order = 109,
		name = L["Skins"],
		desc = L["Apply new shadow style for ElvUI."],
		icon = W.Media.Icons.skins,
		args = {},
	},
	misc = {
		order = 110,
		name = L["Misc"],
		desc = L["Miscellaneous modules."],
		icon = W.Media.Icons.misc,
		args = {},
	},
	advanced = {
		order = 111,
		name = L["Advanced"],
		desc = L["Advanced settings."],
		icon = W.Media.Icons.advanced,
		args = {},
	},
	information = {
		order = 112,
		name = L["Information"],
		desc = L["Credits & help."],
		icon = W.Media.Icons.information,
		args = {},
	},
}

local tempString = strrep("Z", 14)

local r1, g1, b1 = HexToRGB("f0772f")
local r2, g2, b2 = HexToRGB("f34a62")
local r3, g3, b3 = HexToRGB("bb77ed")
local r4, g4, b4 = HexToRGB("1cdce8")
local tempString = E:TextGradient(tempString, r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4)

local color = {}

gsub(tempString, "cff(......)Z", function(self)
	color[#color + 1] = self
end)

-- ElvUI_OptionsUI 回调
function W:OptionsCallback()
	-- 标题
	local icon = F.GetIconString(W.Media.Textures.smallLogo, 14)
	E.Options.name = E.Options.name .. " + " .. icon .. " " .. W.Title .. " |cff00d1b2" .. W.Version .. "|r"

	-- 设置主界面
	E.Options.args.WindTools = {
		type = "group",
		childGroups = "tree",
		name = icon .. " " .. W.Title,
		args = {
			beforeLogo = {
				order = 1,
				type = "description",
				fontSize = "medium",
				name = " ",
				width = "full",
			},
			logo = {
				order = 2,
				type = "description",
				name = "",
				image = function()
					return W.Media.Textures.title, 364, 106.667
				end,
				imageCoords = F.GetTitleTexCoord,
			},
			afterLogo = {
				order = 3,
				type = "description",
				fontSize = "medium",
				name = " \n ",
				width = "full",
			},
		},
	}

	-- 模块设定
	for catagory, info in pairs(W.options) do
		E.Options.args.WindTools.args[catagory] = {
			order = info.order,
			type = "group",
			childGroups = "tab",
			name = "|cff" .. color[info.order - 100] .. info.name,
			desc = info.desc,
			icon = info.icon,
			args = info.args,
		}
	end

	-- Data warmup
	async.WithItemIDTable(E.db.WT.item.extraItemsBar.blackList, "key")
	async.WithItemIDTable(E.db.WT.item.extraItemsBar.customList, "value")
end


W.AnimationEaseTable = {
	["linear"] = L["Linear"],
	["quadratic"] = L["Quadratic"],
	["cubic"] = L["Cubic"],
	["quartic"] = L["Quartic"],
	["quintic"] = L["Quintic"],
	["sinusoidal"] = L["Sinusoidal"],
	["exponential"] = L["Exponential"],
	["circular"] = L["Circular"],
	["bounce"] = L["Bounce"],
}
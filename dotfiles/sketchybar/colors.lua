return {
	transparent = 0x00000000,

	---- Nord theme -----

	-- Blacks. Not in base Nord.
	black0 = 0xff191D24,
	black1 = 0xff1E222A,
	-- Slightly darker than bg.  Very useful for certain popups
	black2 = 0xff222630,

	gray0 = 0xff242933, --bg
	-- Polar Night.
	gray1 = 0xff2E3440,
	gray2 = 0xff3B4252,
	gray3 = 0xff434C5E,
	gray4 = 0xff4C566A,
	-- A light blue/gray.
	-- From @nightfox.nvim.
	gray5 = 0xff60728A,

	-- Dim white.
	-- default fg, has a blue tint.
	white0_normal = 0xffBBC3D4,
	-- less blue tint
	white0_reduce_blue = 0xffC0C8D8,

	-- Snow storm.
	white1 = 0xffD8DEE9,
	white2 = 0xffE5E9F0,
	white3 = 0xffECEFF4,

	-- Frost.
	blue0 = 0xff5E81AC,
	blue1 = 0xff81A1C1,
	blue2 = 0xff88C0D0,

	cyan = {
		base = 0xff8FBCBB,
		bright = 0xff9FC6C5,
		dim = 0xff80B3B2,
	},

	-- Aurora.
	-- These colors are used a lot, so we need variations for them.
	-- Base colors are from original Nord palette.
	red = {
		base = 0xffBF616A,
		bright = 0xffC5727A,
		dim = 0xffB74E58,
	},
	orange = {
		base = 0xffD08770,
		bright = 0xffD79784,
		dim = 0xffCB775D,
	},
	yellow = {
		base = 0xffEBCB8B,
		bright = 0xffEFD49F,
		dim = 0xffE7C173,
	},
	green = {
		base = 0xffA3BE8C,
		bright = 0xffB1C89D,
		dim = 0xff97B67C,
	},
	magenta = {
		base = 0xffB48EAD,
		bright = 0xffBE9DB8,
		dim = 0xffA97EA1,
	},

	bar = {
		bg = 0x00000000,
		border = 0xff191D24,
	},

	popup = {
		bg = 0xff242933,
		border = 0xff191D24,
	},

	bg1 = 0xff2E3440,
	bg2 = 0xe0313436,

	accent = 0xFFb482c2,
	accent_bright = 0x33efc2fc,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}

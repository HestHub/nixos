return {
	default = 0x80ffffff,
	black = 0xff191D24,
	white = 0xffBBC3D4,
	red = 0xfffc5d7c,
	red_bright = 0xe0f38ba8,
	green_dim = 0xff97B67C,
	green = 0xffA3BE8C,
	blue = 0xff81A1C1,
	blue2 = 0xff88C0D0,
	blue_bright = 0xe089b4fa,
	yellow = 0xffe7c664,
	orange = 0xfff39660,
	magenta = 0xffb39df3,
	transparent = 0x00000000,

	gray0 = 0xff242933, --bg
	-- Polar Night.
	gray1 = 0xff2E3440,
	gray2 = 0xff3B4252,
	gray3 = 0xff434C5E,
	gray4 = 0xff4C566A,

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

	spotify_green = 0xe040a02b,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}

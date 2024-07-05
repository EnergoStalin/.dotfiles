local function info(content)
	return ya.notify {
		title = "ffmpeg",
		content = content,
		timeout = 5,
	}
end

local selected_url = ya.sync(function()
	for _, u in pairs(cx.active.selected) do
		return u
	end
end)

local hovered_url = ya.sync(function()
	local h = cx.active.current.hovered
	return h and h.url
end)

local function has_same_extension(a, b)
	local ext = a:match("%.(.*)")
	local ext2 = b:match("%.(.*)")

	return ext == ext2
end

return {
	entry = function()
		local selected, hovered = tostring(selected_url()), tostring(hovered_url())
		if not selected then
			return info("No file selected")
		elseif not hovered then
			return info("No file hovered")
		elseif has_same_extension(selected, hovered) then
			return info("Must have same extension")
		end

		local output, err = Command("ffmpeg")
			:arg("-i"):arg(selected)
			:arg("-i"):arg(hovered)
			:arg("-c:a"):arg("copy")
			:arg("-c:v"):arg("copy")
			:arg("-map"):arg("0:a:0")
			:arg("-map"):arg("1:v")
			:arg("-y"):arg("mix" .. selected:match("%.(.*)"))
			:output()
		if not output then
			return info("Failed to run ffmpeg, error: " .. err)
		end

		info("Audio from e" .. hovered .. "' replaced with '" .. selected .. "' audio")
	end,
}

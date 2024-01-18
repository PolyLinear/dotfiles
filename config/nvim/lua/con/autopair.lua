local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")

for _, bracket in pairs({ { "(", ")" }, { "[", "]" }, { "{", "}" } }) do
	npairs.add_rules({
		Rule(bracket[1], bracket[2]):end_wise(function()
			return true
		end),
	})
end

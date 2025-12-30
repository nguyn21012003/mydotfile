local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node

local function in_mathzone()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

ls.add_snippets("tex", {
  s({ trig = "$", wordTrig = true, snippetType = "autosnippet" }, {
    t("$"),
    i(1),
    t("$"),
    f(function(args)
      local next_text = args[1][1]
      if next_text ~= "" and not string.match(next_text, "^[,%.%?%-%s]") then
        return " "
      end
      return ""
    end, { 2 }),
    i(2),
  }),
})

ls.add_snippets("tex", {
  s({
    trig = "%(",
    regTrig = true,
    snippetType = "autosnippet",
  }, {
    t("( "),
    i(1),
    t(" )"),
  }),
})

ls.add_snippets("tex", {
  s({
    trig = "%{",
    regTrig = true,
    snippetType = "autosnippet",
  }, {
    t("{"),
    i(1),
    t("}"),
  }),
})

ls.add_snippets("tex", {
  s({
    trig = "%[",
    regTrig = true,
    snippetType = "autosnippet",
  }, {
    t("[ "),
    i(1),
    t(" ]"),
  }),
})

ls.add_snippets("tex", {
  s({
    trig = "lr(",
    snippetType = "autosnippet",
    condition = in_mathzone,
  }, {
    t("\\left( "),
    i(1),
    t(" \\right)"),
  }),
})

ls.add_snippets("tex", {
  s({
    trig = "lr[",
    snippetType = "autosnippet",
    condition = in_mathzone,
  }, {
    t("\\left[ "),
    i(1),
    t(" \\right]"),
  }),
})

ls.add_snippets("tex", {
  s({
    trig = "lr{",
    snippetType = "autosnippet",
    condition = in_mathzone,
  }, {
    t("\\left\\{ "),
    i(1),
    t(" \\right\\}"),
  }),
})

ls.add_snippets("tex", {
  s({
    trig = "fr",
    wordTrig = false,
    snippetType = "autosnippet",
    condition = in_mathzone,
  }, {
    t("\\frac{"),
    i(1),
    t("}{"),
    i(2),
    t("}"),
    i(0),
  }),
})

ls.add_snippets("tex", {
  s({
    trig = "((\\d+)|(\\d*)(\\\\)?([A-Za-z]+)((\\^|_)(\\{\\d+\\}|\\d))*)/",
    regTrig = true,
    wordTrig = false,
    snippetType = "autosnippet",
    condition = in_mathzone,
  }, {
    t("\\frac{"),
    f(function(_, snip)
      return snip.captures[1]
    end),
    t("}{"),
    i(1),
    t("}"),
    i(0),
  }),
})

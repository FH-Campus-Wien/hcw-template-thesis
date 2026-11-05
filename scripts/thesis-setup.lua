local setup_path = "setup.tex"

local handle = io.open(setup_path, "r")
if not handle then
  error("HCW thesis setup not found: " .. setup_path)
end

local setup = handle:read("*a")
handle:close()

local language = setup:match([[\newcommand%s*{\HCWLanguage}%s*{([%a]+)}]])
local level = setup:match([[\newcommand%s*{\HCWThesisLevel}%s*{([%a]+)}]])

if language ~= "de" and language ~= "en" then
  error("Invalid HCWLanguage in setup.tex: use de or en")
end

if level ~= "ba" and level ~= "ma" then
  error("Invalid HCWThesisLevel in setup.tex: use ba or ma")
end

local function has_class(element, expected)
  for _, class_name in ipairs(element.classes) do
    if class_name == expected then
      return true
    end
  end
  return false
end

function Meta(meta)
  local active_language = pandoc.utils.stringify(meta.lang or "")
  local profile_matches =
    (language == "de" and active_language:match("^de")) or
    (language == "en" and active_language:match("^en"))

  if not profile_matches then
    error(
      "The active Quarto language profile does not match setup.tex. " ..
      "Use scripts/thesis.sh to build or preview the thesis."
    )
  end

  meta["hcw-language"] = pandoc.MetaString(language)
  meta["hcw-thesis-level"] = pandoc.MetaString(level)
  return meta
end

function Div(element)
  if has_class(element, "hcw-lang-de") then
    return language == "de" and element.content or {}
  end

  if has_class(element, "hcw-lang-en") then
    return language == "en" and element.content or {}
  end

  return nil
end

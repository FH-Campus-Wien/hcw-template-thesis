local setup_path = "setup.tex"
local main_matter_started = false
local text_layout = "front"

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

function Meta(meta)
  local active_language = pandoc.utils.stringify(meta.lang or "")
  local profile_matches =
    (language == "de" and active_language:match("^de")) or
    (language == "en" and active_language:match("^en"))

  if not profile_matches then
    error(
      "The active Quarto language profile does not match setup.tex. " ..
      "Use internal/scripts/thesis.sh to build or preview the thesis."
    )
  end

  meta["hcw-language"] = pandoc.MetaString(language)
  meta["hcw-thesis-level"] = pandoc.MetaString(level)
  return meta
end

-- Die deutsche BA/MA-V1 unterscheidet sich an einer Stelle im Wortlaut.
-- Beide Fassungen bleiben im Markdown sichtbar; gerendert wird nur die Auswahl.
function Div(block)
  if (block.classes:includes("hcw-ba") and level ~= "ba") or
     (block.classes:includes("hcw-ma") and level ~= "ma") then
    return {}
  end
  return nil
end

-- Kurzbeschriftungen auch bei Teilabbildungen und als Grafik eingefügten
-- Tabellen in die PDF-Verzeichnisse übernehmen, nicht nur bei Einzelbildern.
function FloatRefTarget(float)
  local short = float.attributes["tbl-scap"] or float.attributes["fig-scap"]
  if not short then
    return nil
  end
  local parsed = pandoc.read(short, "markdown")
  if #parsed.blocks > 0 and parsed.blocks[1].content then
    -- Quarto erwartet hier ein einzelnes Inline-Element, keine verschachtelte
    -- Inlines-Liste; Span erhält auch Mathematik in der Kurzbeschriftung.
    float.caption_short = pandoc.Span(parsed.blocks[1].content)
    -- Der LaTeX-Renderer verwendet für alle Float-Typen diesen Schlüssel.
    float.attributes["fig-scap"] = short
    return float
  end
  return nil
end

-- Nummerierte Kapitel gehören zum Haupttext, nachfolgende unnummerierte
-- Kapitel zum Nachspann. Dadurch bleibt der Randwechsel unabhängig von
-- Dateinamen und bearbeitbaren Kapitelüberschriften.
function Header(header)
  if not quarto.doc.is_format("pdf") or header.level ~= 1 then
    return nil
  end

  local unnumbered = header.classes:includes("unnumbered")
  local next_layout = text_layout
  if not unnumbered then
    main_matter_started = true
    next_layout = "main"
  elseif main_matter_started then
    next_layout = "back"
  end

  if next_layout == text_layout then
    return nil
  end

  text_layout = next_layout
  local command = next_layout == "main" and "\\HCWMainMatterLayout" or "\\HCWBackMatterLayout"
  return { pandoc.RawBlock("latex", command), header }
end

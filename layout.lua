local CurrentPage = PageNames[props["page_index"].Value]
if CurrentPage == "Devices" then
  local varXi = 21 --initial x position
  local varYi = 12 --initial y position
  local varSpacing = 20 --element spacing variable
  local tblFillColor = {200, 200, 200} --groupbox fill color
  local varW = 550 --groupbox initial width
  local varH = 125 --groupbox initial height
  local varPadding = 12 --padding variable
  local varHeaderOffset = 16 --offset for the groupbox header text
  local varCornerRadius = 8 --corner radius 
  local varWDays = 61 --width for schedule days buttons
  local varHDays = 32 --height for schedule days buttons
  local varBtnColour = {160, 209, 247}

  --Logo
  Logo = "--[[ #encode "TVPluginsLogo.jpg" ]]"
  table.insert(graphics,{
    Type = "Image",
    Image = Logo,
    Position = {varXi, varYi + ((varSpacing + varH) * 2)  },
    Size = {varW/2,varH},
  })
  --Status
  layout["Status"] = {
    PrettyName = "Status",
    Style = "Text",
    Position = {varXi + (varW / 2) + varSpacing ,varYi + ((varSpacing + varH) * 2)},
    Size = {(varW/2) - varSpacing,varH},
  }
  --Classroom Name Groupbox
  table.insert(graphics,{
    Type = "GroupBox",
    Text = "Classroom Name",
    Fill = tblFillColor,
    StrokeWidth = 1,
    Position = {varXi,varYi},
    Size = {varW,varH},
    CornerRadius = varCornerRadius,
    HTextAlign = "Left",
  })

  --Plugin Compatibility Groupbox
  table.insert(graphics,{
    Type = "GroupBox",
    Text = "Plugin Compatibility",
    Fill = tblFillColor,
    StrokeWidth = 1,
    Position = {varXi,varYi + varSpacing + varH},
    Size = {varW,varH},
    CornerRadius = varCornerRadius,
    HTextAlign = "Left",
  })

  --Plugin Compatibility Text
  table.insert(graphics,{
    Type = "Label",
    Text = "Plugin is compatible with any other Device Plugins that use QSYS SDK Reserved Control Names for: IPAddress, Username, Password",
    --Color = {255,255,255},
    StrokeWidth = 1,
    Position = {varXi + varPadding,varYi + varSpacing + varH + varHeaderOffset + varPadding},
    Size = {varW - (varPadding * 2),varH - (varHeaderOffset + (varPadding * 2))},
    HTextAlign = "Center",
    StrokeWidth = 0,
  })

  --Update Config Groupbox
  table.insert(graphics,{
    Type = "GroupBox",
    Text = "Update Config",
    Fill = tblFillColor,
    StrokeWidth = 1,
    Position = {varXi + varSpacing + varW,varYi},
    Size = {varW,varH},
    CornerRadius = varCornerRadius,
    HTextAlign = "Left",
  })

  --Encryption Groupbox
  table.insert(graphics,{
    Type = "GroupBox",
    Text = "Scheduled Updates",
    Fill = tblFillColor,
    StrokeWidth = 1,
    Position = {varXi + varSpacing + varW,varYi + varSpacing + varH},
    Size = {varW,varH},
    CornerRadius = varCornerRadius,
    HTextAlign = "Left",
  })

  --Scheduled Updates Groupbox
  table.insert(graphics,{
    Type = "GroupBox",
    Text = "Encryption",
    Fill = tblFillColor,
    StrokeWidth = 1,
    Position = {varXi + varSpacing + varW,varYi + ((varSpacing + varH)*2) },
    Size = {varW,varH},
    CornerRadius = varCornerRadius,
    HTextAlign = "Left",
  })

  --Classroom Name Control Layout
  layout["ClassroomName"] = {
    Style = "Text",
    Position = {varXi + varPadding,varYi + varPadding + varHeaderOffset},
    Size = {varW - (varPadding * 2),varH - (varHeaderOffset + (varPadding * 2))},
    HTextAlign = "Center",
    CornerRadius = varCornerRadius,
    --TextBoxStyle = "NoBackground",
  }

  --Update Config Button
  layout["UpdateConfig"] = {
    PrettyName = "Config~Manual Update",
    Style = "Button",
    ButtonStyle = "Momentary",
    Position = {varXi + varSpacing + varW + (varPadding * 2),varYi + varPadding + varHeaderOffset},
    Size = {varW - (varPadding * 4),varH - (varHeaderOffset + (varPadding * 2))},
    HTextAlign = "Center",
    CornerRadius = varCornerRadius,
    Legend = "Manual Update",
    Color = varBtnColour,
    --TextBoxStyle = "NoBackground",
  }

  local tblScheduleDays = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}
  --Update Schedule Days Buttons
  for i = 1,7 do 
    layout["UpdateScheduleDays "..i] = {
      PrettyName = "Automatic Updates~Day Of The Week",
      Style = "Button",
      ButtonStyle = "Toggle",
      Position = {varXi + varSpacing + varW + (varPadding * 2) + (varWDays*(i-1)) + (varPadding*(i-1)) ,varYi + varHeaderOffset + (varSpacing + varH) + varPadding },
      Size = {varWDays,varHDays},
      HTextAlign = "Center",
      CornerRadius = varCornerRadius,
      Legend = tblScheduleDays[i],
      Color = varBtnColour,
      --TextBoxStyle = "NoBackground",
    }
  end

  --Enable Schedule Button
  layout["EnableScheduleDays"] = {
    PrettyName = "Automatic Updates~Enable",
    Style = "Button",
    ButtonStyle = "Toggle",
    Position = {varXi + varSpacing + varW + (varPadding * 2),varYi + varHeaderOffset + (varSpacing + varH) + varPadding + varHDays + (varSpacing/2)},
    Size = {varW - (varPadding * 4),varH - (varHeaderOffset + (varPadding * 6))},
    HTextAlign = "Center",
    CornerRadius = varCornerRadius,
    Legend = "Enable Automatic Scheduling",
    Color = varBtnColour,
    --TextBoxStyle = "NoBackground",
  }

  layout["Encryption"] = {
    PrettyName = "Encryption~Enable",
    Style = "Button",
    ButtonStyle = "Toggle",
    Position = {varXi + varSpacing + varW + (varPadding * 2),(varYi + varHeaderOffset + varPadding + varH)*2},
    Size = {varW - (varPadding * 4),varH - (varHeaderOffset + (varPadding * 2))},
    HTextAlign = "Center",
    CornerRadius = varCornerRadius,
    Legend = "Enable Encryption",
    Color = varBtnColour,
    --TextBoxStyle = "NoBackground",
  }

elseif CurrentPage == "Setup" then
  -- TBD
end
table.insert(ctrls, {
  Name = "ClassroomName",
  ControlType = "Text",
  Count = 1,
  UserPin = true,
  PinStyle = "Output",
})

table.insert(ctrls, {
  Name = "UpdateConfig",
  ControlType = "Button",
  ButtonType = "Momentary",
  Count = 1,
  UserPin = true,
  PinStyle = "Input",
})
 
table.insert(ctrls, {
  Name = "UpdateScheduleDays",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 7,
  UserPin = true,
  PinStyle = "Both",
})

table.insert(ctrls, {
  Name = "EnableScheduleDays",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
  UserPin = true,
  PinStyle = "Both",
})
  
table.insert(ctrls, {
  Name = "Encryption",
  ControlType = "Button",
  ButtonType = "Toggle",
  Count = 1,
  UserPin = true,
  PinStyle = "Both",
})


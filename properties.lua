table.insert(props, {
  Name = "JSON File Name",
  Type = "string",
  Value = "A String",
  Comment = "Name of JSON file on the Core",
})

table.insert(props, {
  Name = "Automatic Updates Time",
  Type = "string",
  Choices = "A String",
  Comment = "Valid Format = Hour:Minute (24 Hour Time)"
})

table.insert(props, {
  Name = "Debug Print",
  Type = "enum",
  Choices = {"None", "Tx/Rx", "Tx", "Rx", "Function Calls", "All"},
  Value = "None"
})

table.insert(props, {
  Name = "JSON File Name",
  Type = "string",
  Value = "A String",
  Comment = "Name of JSON file on the Core",
})

table.insert(props, {
  Name = "Automatic Updates Time",
  Type = "enum",
  Choices = {"0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"},
  Value = "None",
  Comment = "0 = 12am, 23 = 11pm"
})

table.insert(props, {
  Name = "Debug Print",
  Type = "enum",
  Choices = {"None", "Tx/Rx", "Tx", "Rx", "Function Calls", "All"},
  Value = "None"
})

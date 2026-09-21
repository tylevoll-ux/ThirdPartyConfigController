
--------------Import Modules----------------------
rapidjson = require("rapidjson")
--------------------------------------------------

--------------START OF TABLE DECLARATIONS---------
tblConfig = {}
ComponentsTbl = Component.GetComponents()
PluginModules = {}
tblState = {}
tblState["OK"] = 0
tblState["COMPROMISED"] = 1
tblState["FAULT"] = 2
tblState["NOTPRESENT"] = 3
tblState["MISSING"] = 4
tblState["INITIALIZING"] = 5
--------------END OF TABLE DECLARATIONS-----------

--------------PLUGIN PROPERTIES---------
varjsonfile = Properties["JSON File Name"].Value
varAutomaticTime = Properties["Automatic Updates Time"].Value
--------------END OF PLUGIN PROPERTIES-----------

--------------DEBUG SETUP---------
DebugTx, DebugRx, DebugFunction = false, false, false
  DebugPrint = Properties["Debug Print"].Value
  if DebugPrint == "Tx/Rx" then
    DebugTx, DebugRx = true, true
  elseif DebugPrint == "Tx" then
    DebugTx = true
  elseif DebugPrint == "Rx" then
    DebugRx = true
  elseif DebugPrint == "Function Calls" then
    DebugFunction = true
  elseif DebugPrint == "All" then
    DebugTx, DebugRx, DebugFunction = true, true, true
  end
--------------END DEBUG SETUP-----------
function funcSetState(argState, argMessage)
  --Principle: DebugFunction is for tracking logic
  if DebugFunction then print("funcSetState: called") end
  if tblState[argState] == nil then 
    print("funcSetState: Unknown state encountered.")
    --Principle: Errors should always be printed

    return
  end 
  if argMessage == nil then 
    argMessage = ""
  end 
  Controls.Status.Value = tblState[argState]
  Controls.Status.String = argMessage
end 

funcGetComponents = function()
  if DebugFunction then print("funcGetComponents: called") end
  for key, value in pairs(ComponentsTbl) do 
    --If the type of component is a plugin, then add the component to the PluginModules table
    if value.Type == "plugin" then 
      PluginModules[value.Name] = Component.New(value.Name)
    end 
  end 
end 

--Run at startup
funcGetComponents()

--Variable assignment for Encryption
AESkey = "12345678901234567890123456789012"
iv = "1234567890123456"

--Function for reading the plaintext JSON file initially dropped onto the processor
funcReadPlainTextConfig = function()
  if DebugFunction then print("funcReadPlainTextConfig: called") end
--Open the file if it exists, if not print an error
  local file, err = io.open("media/Config/"..varjsonfile..".json", "rb")
  if not file then
    print("Error opening file:", err)
    return
  end
--Read the entire file and store the data in a new variable called data
  local data = file:read("*all")
  --close the file when finished
  file:close()
  if Controls.Encryption.Boolean == true then
    --encrypting the data using the AESkey and iv defined above
    local success, encrypted, encErr = pcall(Crypto.Encrypt, Crypto.Cipher.AES_256_CBC, AESkey, iv, data)
    --if the encryption fails print an error
    if not success then
      print("Encryption Error:", encrypted, encErr)
      return
    end
  --Save the encrypted data to the processor in the destination defined below
    local outFile, outErr = io.open("media/Config/"..varjsonfile..".txt", "wb")
    if outFile then
      outFile:write(Crypto.Base64Encode(encrypted))
      outFile:close()
    else
      print("failed to create file:", outErr)
    end
  else
    tblConfig, err = rapidjson.decode(data)
      if err then
        print(err)
      elseif tblConfig ~= nil then 
        print("JSON decoded successfully:")
        funcSetState("OK", "JSON Decoded Successfully")
        for key, value in pairs(tblConfig) do  
          if type(value) == "table" then 
            for k1, v1 in pairs(value) do  
              for pluginName, pluginComp in pairs(PluginModules) do
                if string.find(k1, pluginName, 1, true) then 
                  for k2, v2 in pairs(v1) do 
                    if k2 == "IpAddress" then 
                      pluginComp['IPAddress'].String = v2
                    elseif k2 == "Username" then 
                      pluginComp['Username'].String = v2
                    elseif k2 == "Password" then 
                      pluginComp['Password'].String = v2
                    end 
                  end
                end
              end  
            end 
          elseif key == "Classroom" then 
            Controls.ClassroomName.String = value 
          --[[elseif key == "NumProjectors" then 
            if value == "Two" then 
              Controls.txt_NumberProjectors.String = "Two"
            elseif value == "One" then 
              Controls.txt_NumberProjectors.String = "One"
            end --]]
          end
        end
      else
        print("Error decoding JSON")
        funcSetState("FAULT", "Error Decoding JSON File")
      end  
    --[[else 
      print("Error opening file")
    end --]]
  end  
end

funcReadEncryptedConfig = function()
  if DebugFunction then print("funcReadEncryptedConfig: called") end
  local success, file, err = pcall(io.open, "media/Config/"..varjsonfile.."Encrypted.txt", "r")
  --file = io.open("media/Config/QSYSConfigEncrypted.txt", "wb")
  if success and file then 
    if file ~= nil then 
      content = file:read("*a")
      basecontent = Crypto.Base64Decode(content)
      decrypt = Crypto.Decrypt(Crypto.Cipher.AES_256_CBC, AESkey, iv, basecontent)
      file:close()

      tblConfig, err = rapidjson.decode(decrypt)
      if err then
        print(err)
        funcSetState("FAULT", err)
      elseif tblConfig ~= nil then 
        print("JSON decoded successfully")
        funcSetState("OK", "JSON Decoded Successfully")
        for key, value in pairs(tblConfig) do  
          if type(value) == "table" then 
            for k1, v1 in pairs(value) do  
              for pluginName, pluginComp in pairs(PluginModules) do
                if string.find(k1, pluginName, 1, true) then 
                  for k2, v2 in pairs(v1) do 
                    if k2 == "IpAddress" then 
                      pluginComp['IPAddress'].String = v2
                    elseif k2 == "Username" then 
                      pluginComp['Username'].String = v2
                    elseif k2 == "Password" then 
                      pluginComp['Password'].String = v2
                    end 
                  end
                end
              end  
            end 
          elseif key == "Classroom" then 
            Controls.ClassroomName.String = value 
          --[[elseif key == "NumProjectors" then 
            if value == "Two" then 
              Controls.txt_NumberProjectors.String = "Two"
            elseif value == "One" then 
              Controls.txt_NumberProjectors.String = "One"
            end --]]
          end
        end
    
      else
        print("Error decoding JSON")
        funcSetState("FAULT", "Error Decoding JSON")
      end  
    else 
      print("Error opening file")
      funcSetState("FAULT", "Error Opening File")
    end 
 end 
end

Controls.UpdateConfig.EventHandler = function(ctl)
  if ctl.Boolean == true then 
    if Controls.Encryption.Boolean == true then
      funcReadEncryptedConfig()
    else 
      funcReadPlainTextConfig()
    end
  end 
end 


--Reload Config At midnight to capture any changes--
function scheduleNextCheck()
    local day = os.date("%A")
    local hour = tonumber(os.date("%H"))
    local min = tonumber(os.date("%M"))
    local daystbl = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"}

    for k,v in pairs(daystbl) do  
      if string.find(v, day) then
        varUpdateDay = k
      end  
    end  
    --if hour == tonumber(varAutomaticTime) then
      if Controls.UpdateScheduleDays[varUpdateDay].Boolean == true then
        if hour == tonumber(varAutomaticTime) then
          if Controls.Encryption.Boolean == true then
            funcReadEncryptedConfig()
          else 
            funcReadPlainTextConfig()
          end  
        end
    end
    Timer.CallAfter(scheduleNextCheck, 60)
end

Controls.EnableScheduleDays.EventHandler = function(ctl)
  if ctl.Boolean == true then
    scheduleNextCheck()
  end  
end  
----------------------------------------------------
function funcInit()
  if DebugFunction then print("funcInit: called") end
  funcSetState("INITIALIZING")
  if Controls.Encryption.Boolean == true then
    funcReadEncryptedConfig()
  else
    funcReadPlainTextConfig()
  end  
  if Controls.EnableScheduleDays.Boolean == true then
    scheduleNextCheck()
  end  
end

funcInit()
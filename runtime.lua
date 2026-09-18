
--------------Import Modules----------------------
rapidjson = require("rapidjson")
--------------------------------------------------

--------------START OF TABLE DECLARATIONS---------
tblConfig = {}
ComponentsTbl = Component.GetComponents()
PluginModules = {}
--------------END OF TABLE DECLARATIONS-----------

funcGetComponents = function()
  for key, value in pairs(ComponentsTbl) do 
    print(value.Name, value.Type)
    --If the type of component is a plugin, then add the component to the PluginModules table
    if value.Type = "plugin" then 
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
--Open the file if it exists, if not print an error
  local file, err = io.open("media/Config/QSYSConfig.json", "rb")
  if not file then
    print("Error opening file:", err)
    return
  end
--Read the entire file and store the data in a new variable called data
  local data = file:read("*all")
  --close the file when finished
  file:close()
  --printing for easier debugging
  print(data)

--encrypting the data using the AESkey and iv defined above
  local success, encrypted, encErr = pcall(Crypto.Encrypt, Crypto.Cipher.AES_256_CBC, AESkey, iv, data)
  --if the encryption fails print an error
  if not success then
    print("Encryption Error:", encrypted, encErr)
    return
  end
--Save the encrypted data to the processor in the destination defined below
  local outFile, outErr = io.open("media/Config/QSYSConfigEncrypted.txt", "wb")
  if outFile then
    outFile:write(Crypto.Base64Encode(encrypted))
    outFile:close()
  else
    print("failed to create file:", outErr)
  end
end

funcReadEncryptedConfig = function()
  local success, file, err = pcall(io.open, "media/Config/QSYSConfigEncrypted.txt", "r")
  --file = io.open("media/Config/QSYSConfigEncrypted.txt", "wb")
  if success and file then 
    if file ~= nil then 
      content = file:read("*a")
      basecontent = Crypto.Base64Decode(content)
      decrypt = Crypto.Decrypt(Crypto.Cipher.AES_256_CBC, AESkey, iv, basecontent)
      --print(content)
      print(decrypt)
      file:close()

      tblConfig, err = rapidjson.decode(decrypt)
      print(err)

      if tblConfig ~= nil then 
        print("JSON decoded successfully:")
        for key, value in pairs(tblConfig) do  
          if type(value) == "table" then 
            for k1, v1 in pairs(value) do  
              for pluginName, pluginComp in pairs(PluginModules) do
                --print(racklinkName, racklinkComp)
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
          end 
          elseif key == "AVerCameras" then 
            if type(value) == "table" then 
              for k1, v1 in pairs(value) do  
                for avercamName, avercamComp in pairs(AverCamModules) do 
                  if string.find(k1, avercamName, 1, true) then
                    for k2,v2 in pairs(v1) do
                      if k2 == "IpAddress" then 
                        avercamComp['txtIPAddress'].String = v2
                      elseif k2 == "Username" then 
                        avercamComp['txtAccountName'].String = v2
                      elseif k2 == "Password" then 
                        avercamComp['txtPassword'].String = v2
                      end 
                    end
                  end
                end  
              end 
            end 
          elseif key == "NetgearSwitches" then
            if type(value) == "table" then 
              for k1, v1 in pairs(value) do 
                for netgearName, netgearComp in pairs(NetgearModules) do 
                  if string.find(k1, netgearName, 1, true) then 
                    for k2, v2 in pairs(v1) do 
                      if k2 == "IpAddress" then 
                        netgearComp['IPAddress'].String = v2
                      elseif k2 == "Username" then 
                        netgearComp['Username'].String = v2
                      elseif k2 == "Password" then 
                        netgearComp['Password'].String = v2
                      end 
                    end
                  end 
                end  
              end 
            end
          elseif key == "Projectors" then 
            if type(value) == "table" then 
              for k1, v1 in pairs(value) do 
                if k1 == "AudL" then 
                  print(k1 , v1)
                  for k2, v2 in pairs(v1) do 
                    if k2 == "IpAddress" then 
                      AudLDisplayModule["IPAddress"].String = v2
                    elseif k2 == "Password" then 
                      AudLDisplayModule["Password"].String = v2
                    end 
                    print(k2, v2)
                  end 
                elseif k1 == "AudR" then  
                  print(k1 , v1)
                  for k2, v2 in pairs(v1) do 
                    if k2 == "IpAddress" then 
                      AudRDisplayModule["IPAddress"].String = v2
                    elseif k2 == "Password" then 
                      AudRDisplayModule["Password"].String = v2
                    end 
                    print(k2, v2)
                  end
                end 
              end
            end
          elseif key == "Microphones" then 
            if type(value) == "table" then 
              for k1, v1 in pairs(value) do 
                for tcc2Name, tcc2Comp in pairs(TCC2Modules) do 
                  if string.find(k1, tcc2Name, 1, true) then 
                    for k2, v2 in pairs(v1) do 
                      if k2 == "IpAddress" then 
                        tcc2Comp['IPAddress'].String = v2
                      elseif k2 == "Username" then 
                        tcc2Comp['Username'].String = v2
                      elseif k2 == "Password" then 
                        tcc2Comp['Password'].String = v2
                      end 
                    end
                  end 
                end  
              end 
            end
          elseif key == "Classroom" then 
            Controls.txt_ClassroomName.String  = value 
          elseif key == "NumProjectors" then 
            if value == "Two" then 
              Controls.txt_NumberProjectors.String = "Two"
            elseif value == "One" then 
              Controls.txt_NumberProjectors.String = "One"
            end 
          end 
        end
    
      else
        print("Error decoding JSON")
      end  
    else 
      print("Error opening file")
    end 
 end 
end

Controls.btn_UpdateConfig.EventHandler = function(ctl)
  if ctl.Boolean then 
    --funcReadPlainTextConfig()
    funcReadEncryptedConfig()
  end 
end 

--Reload Config At midnight to capture any changes--
local function scheduleNextCheck()
    local hour = tonumber(os.date("%H"))
    local min = tonumber(os.date("%M"))
    if hour == 0 and min == 0 then
        funcReadPlainTextConfig()
        funcReadEncryptedConfig()
    end
    Timer.CallAfter(scheduleNextCheck, 60)
end

scheduleNextCheck()
----------------------------------------------------

--funcReadPlainTextConfig()
funcReadEncryptedConfig()
# Third Party Plugin Configurator

This is a plugin that is designed to read a JSON file living on a control processor containing Username, Password, IPAddress information. This plugin is currently compatible with any QSYS plugin that utilizes the standard SDK naming of "Username", "Password", and "IPAddress" in its plugin. 

# JSON File

JSON file currently needs to live on the processor in "media/Config/", however the file can be named whatever you would like and set in Designer via the Properties window. A Sample JSON file is included in this repository for testing, and/or modifying for your own use.

# Plugin Names

In order for the plugin to work for your Designer file ensure that the names you are entering in the JSON file match the plugin name in Designer (properties window).

# Encryption

Encryption support is available and is enabled through the toggle button within the plugin. When enabled the JSON plain text file will be read from the processor and then encrypted and saved into the same directory as a .txt file. If you wish to delete the plaintext JSON file after this process, do so with caution as you will not be able to decrypt the information unless inside this plugin.

# Automatic Updates

Automatic checks for updates is supported in this plugin. It is enabled through the use of individual day toggle buttons, as well as a time of day option located within the properties window for the plugin. Once enabled and meeting the conditions for the time of day and day of week settings the plugin will run checks currently every minute and pull any updated credentials into the designer file.

# Support

If you have any questions or concerns with this plugin, contact me at tylevoll@gmail.com

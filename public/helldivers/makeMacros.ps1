# Function to convert arrow characters to corresponding key codes
function ConvertToKeyCode($arrow) {
    switch ($arrow) {
        "&#x2191;" { return 30 }
        "&#x2190;" { return 17 }
        "&#x2193;" { return 31 }
        "&#x2192;" { return 32 }
        default { return $null }
    }
}

function macroLoop($myArrow) { 
    $MacroEventSingleNode = $xmlDoc.CreateElement("MacroEvent")
	$macroEventsNode.AppendChild($MacroEventSingleNode)
	
	$MacroEventType = $xmlDoc.CreateElement("Type")
	$MacroEventType.InnerText = "1"
	$MacroEventSingleNode.AppendChild($MacroEventType)
	
	$MacroEventKey = $xmlDoc.CreateElement("KeyEvent")
	$MacroEventSingleNode.AppendChild($MacroEventKey)
	
	$keyCodeId = ConvertToKeyCode($myArrow)
	$MacroEventCode = $xmlDoc.CreateElement("Makecode")
	$MacroEventCode.InnerText = $keyCodeId
	$MacroEventKey.AppendChild($MacroEventCode)
}

# Function to generate XML document based on arrow characters
function GenerateXmlDocument($arrows, $filePath) {
    #$counter = 0
	$delay = 50
    $arrowArray = $arrows -split " "
			
	#$filePathArray = "C:\Users\Duder5000\Desktop\testArray.txt"
	#Set-Content -Path $filePathArray -Value $arrowArray	
	
	$xmlDoc = New-Object System.Xml.XmlDocument
	
	# Add XML declaration
	$xmlDeclaration = $xmlDoc.CreateXmlDeclaration("1.0", "utf-8", $null)
	$xmlDoc.AppendChild($xmlDeclaration)

	# Create the root element with namespaces
	$rootNode = $xmlDoc.CreateElement("Macro")
	$rootNode.SetAttribute("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance")
	$rootNode.SetAttribute("xmlns:xsd", "http://www.w3.org/2001/XMLSchema")
	$xmlDoc.AppendChild($rootNode)

	$macroName = "500kg"
	$childNode1 = $xmlDoc.CreateElement("Name")
	$macroGuid = "47aba714-6bd7-4e42-921f-993337c218d9"
	
	$childNode1.InnerText = $macroName
	$rootNode.AppendChild($childNode1)

	$childNode2 = $xmlDoc.CreateElement("Guid")
	$childNode2.InnerText = $macroGuid
	$rootNode.AppendChild($childNode2)
	
	$macroEventsNode = $xmlDoc.CreateElement("MacroEvents")
	$rootNode.AppendChild($macroEventsNode)

	macroLoop("&#x2191;")

###############################################################################################

	foreach ($arrow in $arrowArray) {
		$keyTemp = ConvertToKeyCode $arrow		
		#$counter += 1
	}
	
	# Save the XML document to a file
	$xmlDoc.Save("C:\Users\Duder5000\Desktop\file.xml")
}

# Usage example
$arrows = "&#x2191; &#x2193; &#x2192; &#x2190; &#x2191;"
$filePath = "C:\Users\Duder5000\Desktop\GeneratedMacro.xml"
GenerateXmlDocument $arrows $filePath
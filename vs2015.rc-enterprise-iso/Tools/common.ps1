Function Initialize-VS-Settings ($vsArgs, $unattendFile)
{
	$result = @{ 
		"ProductKey" = ""
	}
	
    #Return back the product key
    if($vsArgs -match "(?:\/ProductKey:(['`"]?)(?<productkey>(?:\w+-)+\w+)(?:\1))") {
        $result["ProductKey"] = $matches['productkey']
    };
	
	if($vsArgs -match "(?:\/Features:(['`"]?)(?<features>(?:\w+ ?)+)(?:\1))"){
        $featuresToAdd = -split $matches['features']
        [xml]$adminXml=Get-Content $unattendFile

        $featuresToAdd | % {
            $feature=$_
            $node=$adminXml.DocumentElement.SelectableItemCustomizations.ChildNodes | ? {$_.Id -eq "$feature"}
            if($node -ne $null){
                $node.Selected="yes"
            }
        }
        $adminXml.Save($unattendFile)
    }

	New-Object PSObject -Property $result
}

Function Get-VS-Installer-Args ($productKey='') {
	$result = "/Passive /NoRestart /NoRefresh /NoWeb /AdminFile $adminFile /Log $env:temp\vs.log"
	if($settings.ProductKey -ne "") {

	    $result = "{0} /ProductKey {1}" -f $result, $settings.ProductKey
	}

	$result
}
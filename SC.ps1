Function DoNotFindMe {
	Try {
		$Keys=Get-ChildItem HKCR:\Installer -Recurse -ErrorAction Stop | Get-ItemProperty -name ProductName -ErrorAction SilentlyContinue
	}
	Catch {
		New-PSDrive -Name HKCR -PSProvider registry -Root HKEY_CLASSES_ROOT -ErrorAction SilentlyContinue | Out-Null
		$Keys=Get-ChildItem HKCR:\Installer -Recurse | Get-ItemProperty -name ProductName -ErrorAction SilentlyContinue
		}
	Finally { 
		foreach ($Key in $Keys) {
			if ($Key.ProductName -like "ScreenConnect*") {
				Write-Host $Key.PSPath
				Rename-ItemProperty -Path $Key.PSPath -Name "ProductName" -NewName "XYZ"
				Write-Host "SomeThingIsGood."
			}
		 }
	}
}
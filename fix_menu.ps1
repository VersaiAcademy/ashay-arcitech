$file = "c:\Users\Admin\Downloads\artchitec\index.htm"
$bytes = [System.IO.File]::ReadAllBytes($file)
$c = [System.Text.Encoding]::UTF8.GetString($bytes)

$pairs = @(
    @("listings/designing-tomorrows-cities/index.htm`"><span`r`n`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`tdata-text=`"%1`$s`">Residential", "listings/residential/index.htm`"><span`r`n`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`tdata-text=`"%1`$s`">Residential"),
    @("listings/designing-tomorrows-cities/index.htm`"><span`r`n`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`tdata-text=`"%1`$s`">Commercial", "listings/commercial/index.htm`"><span`r`n`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`tdata-text=`"%1`$s`">Commercial"),
    @("listings/designing-tomorrows-cities/index.htm`"><span`r`n`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`tdata-text=`"%1`$s`">Institutional", "listings/institutional/index.htm`"><span`r`n`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`tdata-text=`"%1`$s`">Institutional"),
    @("listings/designing-tomorrows-cities/index.htm`"><span`r`n`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`tdata-text=`"%1`$s`">Hospitality", "listings/hospitality/index.htm`"><span`r`n`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`tdata-text=`"%1`$s`">Hospitality"),
    @("listings/designing-tomorrows-cities/index.htm`"><span`r`n`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`tdata-text=`"%1`$s`">Master Plan", "listings/master-plan/index.htm`"><span`r`n`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`tdata-text=`"%1`$s`">Master Plan"),
    @("listings/designing-tomorrows-cities/index.htm`"><span`r`n`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`tdata-text=`"%1`$s`">Interiors", "listings/interiors/index.htm`"><span`r`n`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`t`tdata-text=`"%1`$s`">Interiors")
)

foreach ($pair in $pairs) {
    $c = $c.Replace($pair[0], $pair[1])
}

$newBytes = [System.Text.Encoding]::UTF8.GetBytes($c)
[System.IO.File]::WriteAllBytes($file, $newBytes)
Write-Output "Done"

$locations = @{
    "residential" = "Nawalgarh, Jhunjhunu, Rajasthan"
    "commercial"  = "Pilani, Jhunjhunu, Rajasthan"
    "institutional" = "Jhunjhunu City, Rajasthan"
    "hospitality" = "Mandawa, Jhunjhunu, Rajasthan"
    "master-plan" = "Bissau, Jhunjhunu, Rajasthan"
    "interiors"   = "Fatehpur, Sikar, Rajasthan"
}

foreach ($cat in $locations.Keys) {
    $file = "c:\Users\Admin\Downloads\artchitec\listings\$cat\index.htm"
    $bytes = [System.IO.File]::ReadAllBytes($file)
    $c = [System.Text.Encoding]::UTF8.GetString($bytes)

    # Replace old location with new one
    $oldLoc = switch ($cat) {
        "residential"   { "Green Valley Estate, Sector 21, Churu" }
        "commercial"    { "Business Park, MG Road, Churu" }
        "institutional" { "Education Hub, Station Road, Churu" }
        "hospitality"   { "Tourist District, NH Road, Churu" }
        "master-plan"   { "New Town Development, Outer Ring Road" }
        "interiors"     { "Premium Locations Across Churu" }
    }

    $c = $c.Replace($oldLoc, $locations[$cat])
    $newBytes = [System.Text.Encoding]::UTF8.GetBytes($c)
    [System.IO.File]::WriteAllBytes($file, $newBytes)
    Write-Host "$cat => $($locations[$cat])"
}
Write-Host "Done"

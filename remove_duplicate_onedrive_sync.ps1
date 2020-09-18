# remove duplicate images that got synced to onedrive twice, from a new phone

$path = "$env:OneDrive\Pictures\Samsung Gallery\"

foreach ($file in $(ls $path -Recurse -File)) {
    $dt_from_name = $null
    $dt_from_attr = $file.CreationTime

    # both camera and whatsapp files have timestamp in their names
    # I treat it as "actual" creation timestamp
    try {
        $_ = $file.Name -match '[0-9]{8}'
        $dt_from_name = [datetime]::ParseExact($matches[0],'yyyyMMdd', $null)
    }
    catch {
        "Failed to parse filename $file"
        continue
    }

    if ($dt_from_name -lt $dt_from_attr.Date) {
        rm $file.FullName -Force
    }

}
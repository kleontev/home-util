# move phone image/video uploads to corresponding yearly folders

$pic_dir = "$env:OneDrive\Pictures"
$vid_dir = "$env:OneDrive\Videos"

$files = "Samsung Gallery", "Camera Roll" | % { ls $pic_dir\$_ -Recurse -File }

$files | % { $_.LastWriteTime.Year } | select -Unique | % {
    mkdir $pic_dir\$_ -Force
    mkdir $vid_dir\$_ -Force
}

foreach ($file in $files) {
    $target_dir = if ($file.Extension -eq '.mp4') { $vid_dir } else { $pic_dir }    
    mv $file.FullName $target_dir\$($file.LastWriteTime.Year) -Force
}
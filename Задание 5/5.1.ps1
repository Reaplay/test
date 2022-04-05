$path_source = 'E:\temp\source\*.*'
$path_dest = 'E:\temp\dest\'

Copy-Item -Path $path_source -Destination $path_dest -Recurs

$array_ext = @()

foreach ($file in Get-ChildItem -Path $path_dest -Recurse -File){
    $ext =  $file.Name.split(".")[1]
    $array_ext += $ext
}

foreach ($ext in $array_ext| Select-Object -Unique){
    New-Item -Path $path_dest$ext -ItemType Directory  | Out-Null
    Move-Item -Path $path_dest'*.'$ext -Destination $path_dest$ext 
}

$array_folder=@()
foreach($folder in (Get-ChildItem $path_dest).Name){
    $array_folder+=[PSCustomObject]@{
        count=(Get-ChildItem $path_dest$folder -File).count; 
        Length=(Get-ChildItem $path_dest$folder | Measure-Object -Property Length -sum).Sum;
        folder = $folder
    }
}
$array_folder | Sort-Object count -Descending | Format-Table -Property count, Length, folder
$i=1
foreach ($folder in ($array_folder | where count -lt 3).folder){
    Rename-Item $path_dest$folder $path_dest'small_'$i
    $i++
}
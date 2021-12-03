#part 2
[string[]]$ex = [string[]]($ex -split "`n")
[string[]]$in = [string[]]($in -split "`n")

function day3($data, [int]$x = 0,[int]$y = 0){
$newdata = [System.Collections.ArrayList]$data
for ($p=0; $p -lt $data[0].length; $p++) {
  $newdata
  $a = 0; $search = "0"
  for ($i=0; $i -lt $newdata.Count; $i++) {
    $a += [int]($newdata[$i][$p] -eq "1" ? 1 : -1)
  }
# oxygen generator:
  if ($a -ge 0) { $search = "1" }
# co2 scrubber:
#  if ($a -lt 0) { $search = "1" }
  for ($i=0; $i -lt $newdata.Count; $i++) {
    if ($newdata[$i][$p] -ne $search) {
      $newdata.RemoveAt($i)
      $i--
    }
  }
  $newdata.Count
}
$newdata
}day3 $in

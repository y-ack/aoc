#** Day 3
#*** Part 2
$h=1
$s=0;$i=0;$j=0
$dj = 1; $di = 1
while ($i -lt $in.Length) {
  if ($in[$i][$j % $in[0].Length] -eq "#") {$s++}
  $j += $dj; $i += $di
} $h *= $s
$s=0;$i=0;$j=0
$dj = 3; $di = 1
while ($i -lt $in.Length) {
  if ($in[$i][$j % $in[0].Length] -eq "#") {$s++}
  $j += $dj; $i += $di
} $h *= $s
#... etc.

$in = $in -split "`n"
function part1([int]$x = 0,[int]$y = 0) {
  $in | % {$s = 0; $p = 0} {
    if ($p -ne 0) {
      if (([int]$_) -gt $p) {$s++}
    }
    $p = [int]$_
  }{$s}
} part1

function part2([int]$x = 0,[int]$y = 0) {
  $s=0; $p=0
  # forgot to cast to int[] (sob)
  [int[]]$in = [int[]]$in
  for ($y=2; $y -lt $in.Length; $y++) {
    if($p -ne 0){
      $a = $in[$x] + $in[($x+1)] + $in[($x+2)]
      if ($a -gt $p) { $s++ }
    }
    $p = $in[$x] + $in[($x+1)] + $in[($x+2)]
    $x++
  }
  $s
} part2

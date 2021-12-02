function g([int]$group) { return $Matches[$group+1] }
$in = $in -split "`n"
[int]$x = 0
[int]$c = 0
[int]$d = 0
  $in | % {$s = 0} {
    $tmp = $_ -match "(\w+) (\d)"
    [int]$a = [int](g(1))
    [string]$p = [string](g(0)) # why
    if ($p.Equals("forward")) {$x += $a; $d += $a * $c}
    if ($p.Equals("up")) {$c = $c - $a} 
    if ($p.Equals("down")) {$c = $c + $a}
    " " + $x + " " + $c + " " + $a + " " + $d
  $s = $x * $d
  }{$s}

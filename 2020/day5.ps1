function day5([int]$x = 0,[int]$y = 0) {
  $in | % {$s = 0} {
    #$tmp = ($_ -replace "`n"," ") -match ("")
    [int[]]$r = (0..127)
    [int[]]$c = (0..7)
    [char[]]$_ | % { 
      if ($_ -eq 'F') { $r = $r[0..($r.Length/2)];}
      if ($_ -eq 'B') { $r = $r[($r.Length/2)..($r.Length-1)];}
      if ($_ -eq 'L') { $c = $c[0..($c.Length/2 -2)]; }
      if ($_ -eq 'R') { $c = $c[($c.Length/2)..($c.Length-1)]; }
      #$r -join ','
    }
    $a = $r[0] * 8 + $c[0]
    #" " + $r[0] + ", " + $c[0] + ", = " + $a
    $s = [Math]::Max($s, $a)
  }{$s}
} day5
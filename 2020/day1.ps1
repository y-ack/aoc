** Day 1
*** Part 2 brute force
$in | % -Parallel { #parallel gets result 4000ms (6000 ms sooner) here
  $in = $using:in
  [int]$a = $_
  $in | % {
  [int]$b = $_
  $in | % {
    if (([int]$a + [int]$b + [int]$_) -eq 2020)  { write-host ($a * [int]$_ *$b)}
  }
  }
}


*** Optimized part 1
$in2 = [int[]]$in | sort
 $i=0; $j=$in2.Length - 1
 while (1) {
   if ($in2[$i] + $in2[$j] -eq 2020) {
     break
   } elseif ($in2[$i] + $in2[$j] -gt 2020) {
     $j--
   } else {
     $i++
   }
 }
 $in2[$i] * $in2[$j]

*** Optimized part 2 (3-Sum)
# 30ms, parallel only slows it down
$in2 = [int[]]$in | sort
for ($i = 0; $i -le $in2.Length - 2; $i++) {
  $a = $in2[$i];
  $start = $i + 1;
  $end = $in2.Length - 1;
  while ($start -lt $end) {
    $b = $in2[$start]
    $c = $in2[$end]
    if ($a + $b + $c -eq 2020) {
      write-host ($a * $b * $c)
      break
    } elseif ($a + $b + $c -gt 2020) {
      $end--
    } else {
      $start++
    }
  }
}

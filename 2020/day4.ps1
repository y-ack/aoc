#** Day 4
function day4([int]$x = 0,[int]$y = 0) {
  $in | % {$s = 0} {
    $tmp = ($_ -replace "`n"," ") -match ("((?:[a-z]+):(?:#?[a-zA-Z0-9]+))? ?"*8)
    $p = @{}; $p.Clear()
    $Matches.GetEnumerator() | % {$a=$_.Value;if (-not ($a -match " .* ")) { $a = $a -split ":"; $p.Add($a[0],$a[1]) } }
    $fc = 0
    if ($p.ContainsKey("byr") -and (([int]$p["byr"]) -ge 1920) -and (([int]$p["byr"]) -le 2002)) { $fc++; } 
    if ($p.ContainsKey("iyr") -and ($p["iyr"] -ge 2010) -and ($p["iyr"] -le 2020)) { $fc++ }
    if ($p.ContainsKey("eyr") -and ($p["eyr"] -ge 2020) -and ($p["eyr"] -le 2030)) { $fc++ }
    if ($p.ContainsKey("hgt") -and $p["hgt"].Trim() -match "(\d+)(cm|in)") {
    $hv = [int]$Matches[1];
    if ($Matches[2] -eq "in") { if (($hv -ge 59) -and ($hv -le 76)) { $fc++ }; }
    if ($Matches[2] -eq "cm") { if (($hv -ge 150) -and ($hv -le 193)) { $fc++}}}
    if ($p.ContainsKey("hcl") -and ($p["hcl"].Trim() -match "^#[0-9a-f]{6}$")) { $fc++ }
    if ($p.ContainsKey("ecl") -and (@("amb","blu","brn","gry","grn","hzl","oth").Contains(($p["ecl"].Trim())) )) { $fc++;}
    if ($p.ContainsKey("pid") -and ($p["pid"].Trim() -match "^(?:\d){9}$")) {$fc++;$p["pid"] }
    if ($fc -ge 7) {$s++}
  } {$s}
} day4
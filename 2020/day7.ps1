#* day 7
$set = New-Object System.Collections.Generic.HashSet[string] 
function day7([int]$x = 0,[int]$y = 0) {
  $in -split "`n" | % {$rules = New-Object System.Collections.HashTable} {
    $a = $_ -match "(.*?) bags contain (.*|no other bags)."
    $color = g(0); $rule = g(1);
    $rules.Add($color,(New-Object System.Collections.Generic.List[string]))
    $rule -split ", " | % {
      if ($_ -match "no other bags") { break } else {
        $b = $_ -match "(\d+) ((\w+) (\w+)) bags?"
        for ($i = 0; $i -lt $Matches[1] ; $i++) {
          $subcolor = $Matches[2]
          $rules[$color].Add($subcolor)
        }
      }
    }
    $s = 0; $c = 0
    $tmp = $set.Add("shiny gold")
    do {
      $c = $s
      # something here is broken but i don't know how
      $set | % {
        $target = $_
        $rules.GetEnumerator() | %{
          if ($_.Value -contains $target) 
          { $tmp = $set.Add($_.Key);}
          
        }
      }
      $s = $set.Count
    } while ($s -ne $c)
    return $set.Count - 1
  }
} day7
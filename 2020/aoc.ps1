function g([int]$group) { return $Matches[$group+1] }

$cookie=""
function getinput($year=2021,$day=1) {
  return (Invoke-RestMethod -Method GET -Headers @{Cookie="session=$cookie"} -Uri "https://adventofcode.com/$year/day/$day/input").trimend("`n") 
}
function submit($answer, $level=1, $year=2021, $day=1) {
  $check = Invoke-RestMethod -Method POST -Headers @{Cookie="session=$cookie"} -Body @{level="$level"; answer="$answer"} -Uri "https://adventofcode.com/$year/day/$day/answer"
  return $check.Substring($check.IndexOf('main'),216)
}
function problem($year=2021,$day=1) {
  $example = ""
  $problem = iwr https://adventofcode.com/$year/day/$day -Headers @{Cookie="session=$cookie"}
  $tagstack = New-Object System.Collections.Generic.List[System.ConsoleColor]
  $tagstack.Add([System.ConsoleColor]::White)
  ([regex]"<article(.*?)article>").Matches(($problem.Content -replace"`n","\n"))[0].Value -replace "(<p>)","`n" -replace "(<code>|</code>)","`"" -replace "<li>"," - " -replace "</li>","" -split "<" | %{
    if ($_ -match "^em") {$tagstack.Add([System.ConsoleColor]::Cyan)}
    if ($_ -match "^pre") {$tagstack.Add([System.ConsoleColor]::Red)}
    if ($_ -match "^pre>(.*)") {$example = (g 0) -replace "\\n","`n"}
    if ($_ -match "^h2") {$tagstack.Add([System.ConsoleColor]::Green)}
    if ($_ -match "^(/em|/pre|/h2)") {$tagstack.RemoveAt($tagstack.Count-1)}

    $_ = $_ -replace "^.*>","" -replace "\\n","`n"
    write-host $_ -ForegroundColor $tagstack[($tagstack.Count-1)] -NoNewline
  }
  return $example.Trim('"',"`n")
}

$year = [datetime]::Today.Year; $day = [datetime]::Today.Day + 1;
[string]$ex=problem $year $day
$in = getinput $year $day

#Add/Remove/Contains/IsSubsetOf/Overlaps/UnionWith/SymmetricExceptWith
$set = New-Object System.Collections.Generic.HashSet[int] 
$oset = New-Object System.Collections.Generic.SortedSet[int] #Reverse 
$q = New-Object System.Collections.Generic.Queue[int] #Enqueue/Dequeue/Peek/.Count
$sp = New-Object System.Collections.Generic.Stack[int] #Push/Pop/Peek/.Count
$bits1 = New-Object System.Collections.BitArray(8) #And/Not/Or/Xor/Set/SetAll
$bits2 = New-Object System.Collections.BitArray(8) #LeftShift/RightShift

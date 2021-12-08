function day8($data, [int]$x = 0, [int]$y = 0) {
	[string[]]$data = [string[]]($data -split "\n")
	[long]$sum = 0
	[int[]]$counts = ,0 * 10
	foreach ($d in $data) {
		$temp1 = New-Object System.Collections.Generic.HashSet[char]
		$temp2 = New-Object System.Collections.Generic.HashSet[char]
		$seg_e = New-Object System.Collections.Generic.HashSet[char]		
		$segs_1 = New-Object System.Collections.Generic.HashSet[char]
		$segs_4 = New-Object System.Collections.Generic.HashSet[char]
		$segs_7 = New-Object System.Collections.Generic.HashSet[char]
		$segs_8 = New-Object System.Collections.Generic.HashSet[char]
		$5segs = [List[System.Collections.Generic.HashSet[char]]]::new()
		$6segs = [List[System.Collections.Generic.HashSet[char]]]::new()
		$parts = $d -split " \| "
		$uniq = ($parts[0] -split " ")
		foreach ($dig in $uniq) {
			[System.Collections.Generic.HashSet[char]]$s = [System.Collections.Generic.HashSet[char]]::new($dig)
			if ($s.Count -eq 2) {
				$counts[1]++
				$segs_1 = $s
			}
			if ($s.Count -eq 4) {
				$counts[4]++
				$segs_4 = $s
			}
			if ($s.count -eq 3) {
				$counts[7]++
				$segs_7 = $s
			}
			if ($s.count -eq 7) {
				$counts[8]++
				$segs_8 = $s
			}
						
			if ($s.count -eq 5) {
				$5segs.Add($s)
			}
			if ($s.count -eq 6) {
				$6segs.Add($s)
			}
		}
		#e
		$temp1.Clear() #do you see this, john powershell??
		$temp1.UnionWith($6segs[0]) #this $temp1=$6segs[0] workaround?? fuck you
		$temp1.IntersectWith($6segs[1])
		$temp1.IntersectWith($6segs[2])
		#abfg
		$temp2.Clear() #each one of these cost 10 minutes
		$temp2.UnionWith($segs_8)
		$temp2.ExceptWith($temp1)
		#cde
		$temp2.ExceptWith($segs_4)
		$seg_e.Clear() #david powershell
		$seg_e.UnionWith($temp2)
		
		$out = ($parts[1] -split " ")
		$digits = ""
		foreach ($dig in $out) {

			[System.Collections.Generic.HashSet[char]]$s = [System.Collections.Generic.HashSet[char]]::new($dig)
			if ($s.count -eq 2) {
				$digits += "1"
			}
			if ($s.count -eq 4) {
				$digits += "4"
			}
			if ($s.count -eq 3) {
				$digits += "7"
			}
			if ($s.count -eq 7) {
				$digits += "8"
			}
						
			if ($s.count -eq 5) {
				# 2, 3, 5
				# acdeg, acdfg, abdfg
				$temp1.Clear() #steven powershell
				$temp1.UnionWith($s)
				$temp2.Clear() #jack powershell
				$temp2.UnionWith($s)
				$temp1.IntersectWith($seg_e)
				
				if ($temp1.Count -eq 1) {
					$digits += "2"
				}
				else {
					$temp2.IntersectWith($segs_1)
					if ($temp2.Count -eq 2) {
						$digits += "3"
					}
					else {
						$digits += "5"
					}
				}

			}
			if ($s.count -eq 6) {
				# 0, 6, 9
				# abcefg, abdefg, abcdfg
				$temp1.Clear() #jon powershell
				$temp1.UnionWith($s)
				$temp2.Clear() #peter powershell
				$temp2.UnionWith($s)
				$temp1.IntersectWith($seg_e)
				if ($temp1.Count -eq 0) {
					$digits += "9"
				}
				else {
					$temp2.IntersectWith($segs_1)
					if ($temp2.count -eq 2) {
						$digits += "0"
					}
					else {
						$digits += "6"
					}
				}
			}

		}
		#$digits
		$sum += [long]$digits
	}
	$sum
} day8 $ex

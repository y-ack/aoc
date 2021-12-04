class Board {
	[System.Collections.ArrayList]$values = [System.Collections.ArrayList]::new();
	[int[]]$hits = [int[]]::new(25);
}
function iswin {
	param ([int[]]$hits)
	for ($y = 0; $y -lt 5; $y++) {
		$hitsum = 0
		for ($x = 0; $x -lt 5; $x++) {
			$hitsum += $hits[$y*5 + $x]
		}
		if ($hitsum -eq 5) {return $true}
	}
	for ($x = 0; $x -lt 5; $x++) {
		$hitsum = 0
		for ($y = 0; $y -lt 5; $y++) {
			$hitsum += $hits[$y * 5 + $x]
		}
		if ($hitsum -eq 5) { return $true }
	}	
}
function day4($data, [int]$x = 0, [int]$y = 0) {
	$data = $data -split "`n"
	[int[]]$nums = $data[0] -split ","
	$boards = [System.Collections.ArrayList]::new()
	$cboard = New-Object -TypeName Board
	for ($line = 2; $line -lt $data.Count; $line++) {
		if ($data[$line].Equals("")) {
			$boards.add($cboard) | out-null
			$cboard = New-Object -TypeName Board
			continue
		} else {
			$m = $data[$line] -match "\s*(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)"
			$cboard.values.add([int](g 0)) | out-null
			$cboard.values.add([int](g 1)) | out-null
			$cboard.values.add([int](g 2))  | out-null
			$cboard.values.add([int](g 3))  | out-null
			$cboard.values.add([int](g 4))  | out-null
		}
	}

	for ($i = 0; $i -lt $nums.Count; $i++) {
		for ($b = 0; $b -lt $boards.Count; $b++) {
			$j = $boards[$b].values.IndexOf($nums[$i]);
			if ($j -lt 0) {continue}
			$boards[$b].hits[$j] = 1

			if (iswin($boards[$b].hits)) {
				# for part 2 (skip for part 1)
				if ($boards.count -gt 1) {
					$boards.RemoveAt($b)
					$b--
					continue
				}
				$score = 0
				for ($t = 0; $t -lt 25; $t++) {
					if (-not $boards[$b].hits[$t]) {$score += $boards[$b].values[$t]}
				}
				$boards
				$score; $nums[$i]; $b
				
				return $score * $nums[$i]
			}
		}
	}
} day4 $in

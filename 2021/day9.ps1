using namespace System.Collections.Generic
#region example
[string]$ex = "2199943210
3987894921
9856789892
8767896789
9899965678"
#endregion

function isvalid {
	param (		$maxX, $maxY, $cX, $cY	)
	#Write-Host "$cX, $cY"
	if (($cX -ge 0) -and ($cX -lt $maxX) -and
			 ($cY -ge 0) -and ($cY -lt $maxY)) {
		return $true
	}
	return $false
}

function day9($data, [int]$x = 0, [int]$y = 0) {
	[string[]]$data = [string[]]($data -split "`n")
	$sum = 0
	$sumsize = 0
	$maxY = $data.Length
	$maxX = $data[0].Length #uh-oh!! numbers!!
	[List[int]]$sizes = [List[int]]::new()
	for ($y = 0; $y -lt $data.Length; $y++) {
		for ($x = 0; $x -lt $data[$y].Length; $x++) {
			$p = [int]$data[$y][$x]
			if ($y -ne 0) {
				if ($p -ge ([int]$data[$y - 1][$x])) {
					continue
				}
			}
			if ($y -ne ($data.Length - 1)) {
				if ($p -ge ([int]$data[$y + 1][$x])) {
					continue
				}
			}
			if ($x -ne 0) {
				if ($p -ge ([int]$data[$y][$x - 1])) {
					continue
				}
			}
			if ($x -ne ($data[$y].Length - 1)) {
				if ($p -ge ([int]$data[$y][$x + 1])) {
					continue
				}
			}
			$q = [Queue[System.Drawing.Point]]::new()
			$q.Enqueue([System.Drawing.Point]::new($x, $y))
			$temp = [char[]]$data[$y]
			$temp[$x] = '9'
			$data[$y] = $temp -join "" # spaces... there are really spaces...
			$size = 1
			while ($q.Count -gt 0) {
				$cur = $q.Dequeue()
				
				[int]$cX = $cur.X
				[int]$cY = $cur.Y
				$size
				$data
				if (isvalid ($maxX) ($maxY) ($cX + 1) $cY) {
          # uh-oh!!! numbers!! parsee you later!!!
					$v = [int]("0" + [string]$data[$cY][$cX + 1])
					if ($v -lt 9) {
						$size += 1
						$temp = [char[]]$data[$cY]
						$temp[$cX + 1] = '9'
						$data[$cY] = $temp -join "" # uh-oh!! spaces!!!
						$q.Enqueue([System.Drawing.Point]::new($cX + 1, $cY))
					}
				}
				if (isvalid ($maxX) ($maxY) ($cX - 1) $cY) {
          # numbers machine broke :(
					$v = [int]("0" + [string]$data[$cY][$cX - 1])
					if ($v -lt 9) {
						$size += 1
						$temp = [char[]]$data[$cY]
						$temp[$cX - 1] = '9'
						$data[$cY] = $temp -join ""
						$q.Enqueue([System.Drawing.Point]::new($cX - 1, $cY))
					}
				}
				if (isvalid ($maxX) ($maxY) $cX ($cY + 1)) {
          # $x variables name :( numbers!! numbers and letters ... uh-oh!! uh-oh numbers!!
					$v = [int]("0" + [string]$data[$cY + 1][$cX])
					if ($v -lt 9) {
						$size += 1
						$temp = [char[]]$data[$cY + 1]
						$temp[$cX] = '9'
						$data[$cY + 1] = $temp -join ""
						$q.Enqueue([System.Drawing.Point]::new($cX, $cY + 1))
					}
				}
				if (isvalid ($maxX) ($maxY) $cX ($cY - 1)) {
					$v = [int]("0" + [string]$data[$cY - 1][$cX])
					if ($v -lt 9) {
						$size += 1
						$temp = [char[]]$data[$cY - 1]
						$temp[$cX] = '9'
						$data[$cY - 1] = $temp -join ""
						$q.Enqueue([System.Drawing.Point]::new($cX, $cY - 1))
					}
				}
			}
			$null = $sizes.Add($size)
			$sum += 1 + ($p - 48)
		}
	}
	$sum
	($sizes | sort -Bottom 3)
} day9 $ex

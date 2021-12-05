using namespace System.Collections.Generic

[regex]$r1 = "(\d+),(\d+) -> (\d+),(\d+)"
function g([int]$group) { return $Matches[$group + 1] }
function gridkey {param ([int]$x,[int]$y)
	return [string]$x + "," + [string]$y
}
function showgrid {
	param ($grid,$maxx,$maxy)
	for ($y = 0; $y -le $maxy; $y++) {
		for ($x = 0; $x -le $maxx; $x++) {
			if ($grid.Item((gridkey $x $y)) -gt 0) {
				write-host $grid.item((gridkey $x $y)) -NoNewline
			}
			else {
				write-host "." -NoNewline
			}	
		}
		write-host ""
	}
}

function day5($data, [int]$x = 0, [int]$y = 0) {
	$data = $data -split "`n"
	$maxx = 0;$maxy = 0 #just for printing,(full grid too big anyway)
	$grid = @{}
	for ($i = 0; $i -lt $data.Count; $i++) {
		$m = $data[$i] -match $r1
		[int]$x1 = [int](g(0))
		[int]$y1 = [int](g(1))
		[int]$x2 = [int](g(2))
		[int]$y2 = [int](g(3))
		# straight lines
		if (($x1 -eq $x2) -or ($y1 -eq $y2)) {
			# reorder points for convenience
			if ($x1 -gt $x2) {
				$x1,$x2 = $x2,$x1
			}
			if ($y1 -gt $y2) {
				$y1,$y2 = $y2,$y1
			}
			$maxx = [System.Math]::Max($maxx, $x2)
			$maxy = [System.Math]::Max($maxy, $y2)

			#increment hits at points along line
			for ($x = $x1; $x -le $x2; $x++) {
				for ($y = $y1; $y -le $y2; $y++) {
					$grid.Item((gridkey $x $y)) += 1
				}
			}
		}
		else { # diagonal line
			# 45 degrees means dX must == dY
			if ($x1 -gt $x2) { # x as primary
				$x1, $x2 = $x2, $x1
				$y1, $y2 = $y2, $y1 # if x swaps, swap y too
			}
			$y = $y1
			for ($x = $x1; $x -le $x2; $x++) {
				$grid.Item((gridkey $x $y)) += 1
				$y += [math]::Sign($y2 - $y1) # y has signed inc
			}
		}
	}

	# printing the grid for debug
	showgrid $grid $maxx $maxy
	# count collisions
	$sum = 0
	$grid.GetEnumerator() | % { $sum += [int]($_.value -gt 1) }
	$sum | Set-Clipboard
} day5 $ex

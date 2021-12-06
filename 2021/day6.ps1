using namespace System.Collections.Generic

function day6($data, [int]$x = 0, [int]$y = 0) {
	[List[int]]$data = [List[int]]::new([int[]]($data -split ","))

	for ($d = 0; $d -lt 80; $d++) {
		$data -join ","			
		for ($i = $data.Count -1; $i -ge 0 ; $i--) {
			$data[$i] = $data[$i] - 1;
			if ($data[$i] -eq -1) {
				$data[$i] = 6
				$data.Add(8)	
			}
		}
	}
	$data.count
} day6 $ex


function day6_2($data, [int]$x = 0, [int]$y = 0) {
	[List[int]]$data = [List[int]]::new([int[]]($data -split ","))
	[int64[]]$counts = [int64[]]::new(9)

	for ($i = 0; $i -lt 9; $i++) {
		$counts[$i] = ($data | ? {$_ -eq $i}).Count
	}
	
	for ($d = 0; $d -lt 18; $d++) {
		$a = $counts[0]
		for ($i = 1; $i -lt 9; $i++) {
			$counts[$i-1] = $counts[$i]
		}	
		$counts[6] += $a
		$counts[8] = $a
	}
	$sum = 0
	for ($i = 0; $i -lt 9; $i++) {
		$sum += $counts[$i]
	}
	$sum
} day6_2 $ex

$memo = @{}
function memoed($a) {
	$sum = 0
	if ($a -eq 0) { return 0 }
	if (-not $memo.ContainsKey($a)) {
		$sum += $a + (memoed($a - 1))
		$memo.Add($a, $sum)
	}
	return $memo[$a];
}

function day7_2($data, [int]$x = 0, [int]$y = 0) {
	[int[]]$data = [int[]]($data -split ",")
	$min = ($data | Measure-Object -Minimum).Minimum
	$max = ($data | Measure-Object -Maximum).Maximum
	[long]$best = 1000000000
	for ($d = $min; $d -lt $max; $d++) {
		$sum = 0
		foreach ($i in $data) {
			$sum += [long](memoed ([math]::Abs($i - $d)))
		}
		$best = [Math]::Min($sum, $best)
	}
	$best
} day7_2 $in


$memo = @{}
function memoed2($a) {
	if (-not $memo.ContainsKey($a)) {
		$triangle = [Math]::FusedMultiplyAdd($a, $a, $a) -shr 1
		$memo.Add($a, $triangle)
	}
	return $memo[$a];
}
function day7_2o($data, [int]$x = 0, [int]$y = 0) {
	[int[]]$data = [int[]]($data -split ",")
	[int]$mean = ($data | Measure-Object -Average).Average
	[long]$best = 1000000000
	# mean by itself /shouldn't/ be correct
	# is there a way to prove a correct range to check,
	# based on the stddev or something?
	for ($d = [int]$mean - 1; $d -lt [int]$mean + 1; $d++) {
		$cost = 0
		foreach ($i in $data) {
			$cost += (memoed2 ([math]::Abs($i - $d)))
		}
		$best = [Math]::Min($cost, $best)
	}
	$best
} day7_2o $in

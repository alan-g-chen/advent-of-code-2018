$items = get-content .\test.txt

$runningTotal = 0
foreach($item in $items)
{
    $isPositive = $item[0] -eq '+'
    $item = $item.Substring(1, $item.Length-1)
    if ($isPositive)
    {
        $runningTotal += [int]$item 
    }
    else
    {
        $runningTotal -= [int]$item
    }
}

Write-Host "Total: $runningTotal"
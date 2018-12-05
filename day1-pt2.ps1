$items = get-content .\test.txt

$frequencyHashTable = @{}
$duplicateNotReached = $true
$runningTotal = 0
while ($duplicateNotReached)
{
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

        if ($frequencyHashTable[$runningTotal] -ne $null)
        {
            Write-Host "Detected duplicate: $runningTotal"
            $duplicateNotReached = $false
            return
        }
        else
        {
            $frequencyHashTable[$runningTotal] =  $frequencyHashTable[$runningTotal] + 1
        }
    }
}

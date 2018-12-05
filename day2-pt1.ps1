$items = Get-Content .\test.txt

$characterHashTable = @{}
$doubles = 0
$triples = 0

foreach ($item in $items)
{
    for ($i = 0; $i -lt $item.Length; $i++)
    {
        $char = $item.Chars($i)
        if ($characterHashTable[$char] -eq $null)
        {
            $characterHashTable[$char] = 1
        }
        
        else
        {
            $characterHashTable[$char] = $characterHashTable[$char] + 1;

        }
    }

    foreach ($kvp in $characterHashTable)
    {
            $hasDouble = $characterHashTable.ContainsValue(2)
            $hasTriple = $characterHashTable.ContainsValue(3)
    }       

    if ($characterHashTable.ContainsValue(2)) { $doubles++ }
    if ($characterHashTable.ContainsValue(3)) { $triples++ }

    # Reset for next one
    $characterHashTable = @{}
}

Write-Host "Checksum is $($doubles * $triples)"
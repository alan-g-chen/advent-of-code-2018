#brute force approach

function IsOffByOne
{
    param
    (
        [string]$FirstInput,
        [string]$SecondInput
    )
    if ($FirstInput.Length -ne $SecondInput.Length)
    {
        return $false
    }

    $offByCount = 0
    for ($i = 0; $i -lt $FirstInput.Length; $i++)
    {
        if ($FirstInput[$i] -ne $SecondInput[$i])
        {
            $offByCount++
        }
    }
    return ($offByCount -eq 1)
}

$items = Get-Content .\test.txt

for ($j = 0; $j -lt $items.Count; $j++)
{
    $FirstItem = $items[$j];
    for ($k = $j + 1; $k -lt $items.Count; $k++)
    {
        $SecondItem = $items[$k]
        if (IsOffByOne -FirstInput $FirstItem -SecondInput $SecondItem)
        {
            Write-Output "Item 1: $FirstItem"
            Write-Output "Item 2: $SecondItem"
            return
        }
    }
}

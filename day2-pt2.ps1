<#

Confident that your list of box IDs is complete, you're ready to find the boxes full of prototype fabric.

The boxes will have IDs which differ by exactly one character at the same position in both strings. For example, given the following box IDs:

abcde
fghij
klmno
pqrst
fguij
axcye
wvxyz
The IDs abcde and axcye are close, but they differ by two characters (the second and fourth). However, the IDs fghij and fguij differ by exactly one character, the third (h and u). Those must be the correct boxes.

What letters are common between the two correct box IDs? (In the example above, this is found by removing the differing character from either ID, producing fgij.)

#> 

# Brute force approach

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

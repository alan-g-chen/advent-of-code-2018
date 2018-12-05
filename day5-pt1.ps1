# Create a helper function that removes pairs

function Remove-Pairs
{
    param
    (
        [string] $StringToParse
    )

    $charLastSeen = $StringToParse[$StringToParse.Length-1]
    $previousCharIsLower = [System.Char]::IsLower($charLastSeen)

    for ($i = $StringToParse.Length - 2; $i -ge 0; $i--)
    {
        $currentCharIsLower = [System.Char]::IsLower($StringToParse[$i])
        if (($previousCharIsLower -ne $currentCharIsLower) -and ([System.Char]::ToLower($charLastSeen) -eq [System.Char]::ToLower($StringToParse[$i])))
        {
            $StringToParse = $StringToParse.Remove($i, 2)
            $charLastSeen = ' '
        }
        else
        {
            $charLastSeen = $StringToParse[$i]
            $previousCharIsLower = $currentCharIsLower
        }
    }
    
    return $StringToParse
}


# Get the content
$content = Get-Content .\test.txt

$parsedContent1 = $content
$parsedContent2 = Remove-Pairs -StringToParse $parsedContent1
$iteration = 1
While ($parsedContent1 -ne $parsedContent2)
{
    Write-Output "Iteration: $iteration"
    $parsedContent1 = $parsedContent2
    $parsedContent2 = Remove-Pairs -StringToParse $parsedContent1
    $iteration++
}

Write-Output "Number of units: $($parsedContent1.Length)"
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

# Move reduction to function

function Get-ReducedValue
{
    param
    (
        [string]$StringToReduce
    )
    
    $parsedContent1 = $StringToReduce
    $parsedContent2 = Remove-Pairs -StringToParse $parsedContent1
    $iteration = 1
    While ($parsedContent1 -ne $parsedContent2)
    {
        $parsedContent1 = $parsedContent2
        $parsedContent2 = Remove-Pairs -StringToParse $parsedContent1
        $iteration++
    }

    return $parsedContent1.Length
}

# Get the content
$content = Get-Content .\test.txt

# We can solve this by reducing 28 times - once for each pair. Since this is just for fun, we can make it pretty hacky with a defined array of values.

$letterArray = "abcdefghijklmnopqrstuvwxyz".ToCharArray()
$minValue = -1
foreach ($letter in $letterArray)
{
    
    Write-Host "Iterating for value [$letter]..." -NoNewline
    $newContent = $content.Replace($letter.ToString(), '')
    $newContent = $newContent.Replace([System.Char]::ToUpper($letter).ToString(), '')
    Write-Host "total length $($newContent.Length)..." -NoNewline
    $potentialUnits = Get-ReducedValue -StringToReduce $newContent
    Write-Host $potentialUnits
    if ($potentialUnits -lt $minValue -or $minValue -eq -1)
    {
        $minValue = $potentialUnits
    }
}

Write-Host "Minimum value found: $minValue"
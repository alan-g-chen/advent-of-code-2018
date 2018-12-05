# Some basic constraints - appears that the input is entirely in integer inches. So, we can use an N x M integer array to represent the fabric, 
# where the integer value represents # of claims.

$claimsArray = New-Object int[][] 1000, 1000 # Intializes with a default value of 0

# Import the provided input
$items = Get-Content .\test.txt
$tooManyClaims = 0

# Let's still run too see the claims first.
foreach ($item in $items)
{
    # Transform the content
    $leftEdge = [int]$item.Substring($item.IndexOf('@') + 2, $item.IndexOf(',') - ($item.IndexOf('@') + 2))
    $topEdge = [int]$item.Substring($item.IndexOf(',') + 1, $item.IndexOf(':') - ($item.IndexOf(',') + 1))

    $width = [int]$item.Substring($item.IndexOf(':') + 2, $item.IndexOf('x') - ($item.IndexOf(':') + 2))
    $height= [int]$item.Substring($item.IndexOf('x') + 1, $item.Length - ($item.IndexOf('x') + 1))

    for ($i = $leftEdge; $i -lt $leftEdge + $width; $i++)
    {
        for ($j = $topEdge; $j -lt $topEdge + $height; $j++)
        {
            $claimsArray[$i][$j]++
            if ($claimsArray[$i][$j] -eq 2) # Once it hits 2, we mark it down as claimed
            {
                $tooManyClaims++
            }
        }
    }
}

# We'll run through the list a second time to exclude any that were claimed too many times. We could probably skip this somehow, but doing it this way still
# provides a runtime of 2N, or linear.

$claimIsValid = $true;
foreach ($item in $items)
{
    # Transform the content
    $leftEdge = [int]$item.Substring($item.IndexOf('@') + 2, $item.IndexOf(',') - ($item.IndexOf('@') + 2))
    $topEdge = [int]$item.Substring($item.IndexOf(',') + 1, $item.IndexOf(':') - ($item.IndexOf(',') + 1))

    $width = [int]$item.Substring($item.IndexOf(':') + 2, $item.IndexOf('x') - ($item.IndexOf(':') + 2))
    $height= [int]$item.Substring($item.IndexOf('x') + 1, $item.Length - ($item.IndexOf('x') + 1))

    for ($i = $leftEdge; $i -lt $leftEdge + $width; $i++)
    {
        for ($j = $topEdge; $j -lt $topEdge + $height; $j++)
        {
            if ($claimsArray[$i][$j] -ge 2) # If it was claimed
            {
                $claimIsValid = $false
                break # Claim is not valid - short circuit.
            }
        }
        if (-not $claimIsValid)
        {
            break  # Claim is not valid - short circuit.
        }
    }
    if ($claimIsValid) # Problem states that only a single claim is valid, so we can short circuit.
    {
        Write-Output "Found the valid claim! $item"
    }
    $claimIsValid = $true
}

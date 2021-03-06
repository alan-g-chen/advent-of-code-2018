﻿<#

Strategy 2: Of all guards, which guard is most frequently asleep on the same minute?

In the example above, Guard #99 spent minute 45 asleep more than any other guard or minute - three times in total. (In all other cases, any guard spent any minute asleep at most twice.)

What is the ID of the guard you chose multiplied by the minute you chose? (In the above example, the answer would be 99 * 45 = 4455.)

#>

# Get timetable and sort it.

$timeTable = Get-Content .\test.txt | Sort-Object

# We'll create a hashtable to represent each guard.
# The key = guard ID
# The value = an array of ints. 
#         The array index = minute
#         The array value = times was asleep

$guardHashTable = @{}

$guardId = -1
$guardIsAsleep = $false

$maxId = -1
$maxMinute = -1
$maxCount = -1

foreach ($row in $timeTable)
{
   # Am I changing guard? If so, wake up the existing guard and log hours (if applicable), then update my guard to the new id, and awake.
   if ($row.Contains("Guard #"))
   {
        if ($guardIsAsleep)
        {
            #wake up previous guard and log hours
            $guardIsAsleep = $false
            $wakingTimeStamp = [DateTime]$row.Substring(1, 16)
            $timeDiff = $wakingTimeStamp - $sleepingTimeStamp

            # instantiate the guard hashtable entry if it doesn't exist
            if ($guardHashTable[$guardId] -eq $null)
            {
                $guardHashTable[$guardId] = New-Object int[] 61
            }
        
            # increment by 1 for each minute difference, starting with sleep time
            while ($sleepingTimeStamp -lt $wakingTimeStamp)
            {
                $guardHashTable[$guardId][60]++;
                $guardHashTable[$guardId][$sleepingTimeStamp.Minute]++
                if ($guardHashTable[$guardId][$sleepingTimeStamp.Minute] -gt $maxCount) # We'll track the minute with the most sleep counts (per guard).
                {
                    $maxId = $guardId
                    $maxMinute = $sleepingTimeStamp.Minute
                    $maxCount = $guardHashTable[$guardId][$sleepingTimeStamp.Minute]
                }
                $sleepingTimeStamp.AddMinutes(1); # This will keep track of rollover forus
            }
        }

        #update the guard
        $indexBegin = $row.IndexOf("#") + 1
        $length = $row.IndexOf(" begins") - $indexBegin
        $guardId = [int]$row.Substring($indexBegin, $length)
        $guardIsAsleep = $false
   }

    
   # Am I falling asleep? Change state to asleep and record sleep start. Can I fall asleep twice in a row? Just in case, ignore that case.
   if ($row.Contains("falls asleep") -and -not $guardIsAsleep)
   {
        $guardIsAsleep = $true
        $sleepingTimeStamp = [DateTime]$row.Substring(1, 16)
   }

   # Am I waking up? Change state to awake and log slept minutes. Can I wake up from a woken state? Just in case, ignore.
   if ($row.Contains("wakes up") -and $guardIsAsleep)
   {
        $guardIsAsleep = $false
        $wakingTimeStamp = [DateTime]$row.Substring(1, 16)
        $timeDiff = $wakingTimeStamp - $sleepingTimeStamp

        # instantiate the guard hashtable entry if it doesn't exist
        if ($guardHashTable[$guardId] -eq $null)
        {
            $guardHashTable[$guardId] = New-Object int[] 61
        }
        
        # increment by 1 for each minute difference, starting with sleep time
        while ($sleepingTimeStamp -lt $wakingTimeStamp)
        {
            $guardHashTable[$guardId][60]++;
            $guardHashTable[$guardId][$sleepingTimeStamp.Minute]++
            if ($guardHashTable[$guardId][$sleepingTimeStamp.Minute] -gt $maxCount) # We'll track the minute with the most sleep counts (per guard).
            {
                $maxId = $guardId
                $maxMinute = $sleepingTimeStamp.Minute
                $maxCount = $guardHashTable[$guardId][$sleepingTimeStamp.Minute]    
            }
            $sleepingTimeStamp = $sleepingTimeStamp.AddMinutes(1); # This will keep track of rollover forus
        }
    }
}
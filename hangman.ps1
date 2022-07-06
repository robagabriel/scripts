Write-Host "
  ________
  |/     |
  |      O
  |      ^ 
  |    / | \ 
  |      ^
  |     / \ 
 /|\ 
/ | \ 
"
Write-Host "Hangman game!
The theme of the game are animals.
You have a selection of 23 animals.
"

$listOfAnimals = @("crocodile", "anaconda", "hippopotamus", "octopus", "alligator", "anteater", "baboon", "dolphin", "lizard", "peacock", "flamingo", "rooster", "gorilla", "buffalo", "caterpillar", "hamster", "chimpanzee", "cougar", "cheetah", "chicken", "elephant", "rattlesnake", "lobster")

$stringLentgh = $listOfAnimals.Count
#Write-Host $stringLentgh
#Write-Host "before while" $hangmanWord
while ($null -eq $hangmanWord) {
    try {
        [int]$hangmanWord = Read-Host "Please enter the Hangman number that represents a word. The intervar is between 1 and" $listOfAnimals.Count
    }
    catch {
        Write-Host "Wrong value was given!"
        Write-Host "The value must be a number from 1 to " $stringLentgh "!"
    }
    
    if (($hangmanWord -gt $stringLentgh) -or ($hangmanWord -match "0")){
        try {
            Remove-Variable hangmanWord -ErrorAction Stop
        }
        catch {
            Write-Host "No value was given!
            "
        }
        #Write-Host "in while, if statement, value of hangman " $hangmanWord
        Write-Host "Wrong value was given!"
        Write-Host "The value must be a number from 1 to " $stringLentgh "!"
    }
}

#($hangmanWord -notmatch '^[0-9]+$') -and  -and (-not ($hangmanWord -le stringLentgh)
#Write-Host $listOfAnimals.GetType()
#Write-Host $stringLentgh.GetType()
#Write-Host $hangmanWord.GetType()
Write-Host "
The value entred is:" $hangmanWord "
"
$animalSelected = $listOfAnimals[$hangmanWord - 1]
#Write-Host $animalSelected

$hangmanAnimal = $animalSelected.ToCharArray()
$hangmanAnimalLength = $animalSelected.Length
#Write-Host "This the word selected" $hangmanAnimal 
#Write-Host "And this is the length of the string" $hangmanAnimalLength
$emptyStringArray = @()
for ($i = 0; $i -lt $hangmanAnimalLength; $i++) {
    $emptyStringArray += "_"
}
Write-Host "Here you go!" 
Write-Host "
" $emptyStringArray "
"
[int]$countFails = 1
#Write-Host $countFails.GetType()
while ($countFails -le 6 ) {
    #$emptyString = $emptyStringArray -join ""
    while (@(Compare-Object $hangmanAnimal $emptyStringArray -SyncWindow 0).Length -ne 0) {
        #Write-Host "in second while, " $animalSelected $emptyString
        Write-Host ""
        try {
            [char]$hangmanLetter = Read-Host "Please enter a letter from the word"
            
        }
        catch {
            Write-Host ""
            Write-Host "The value must be a single letter!
            "
        }
        #Write-Host $hangmanLetter
        #Write-Host $hangmanLetter.GetType()
        if (($hangmanLetter -match '[0-9]') -or ($null -eq $hangmanLetter)) {
            try {
                Remove-Variable hangmanLetter -ErrorAction Stop
            }
            catch {
                Write-Host "No value was given!
                "
            }
            #Remove-Variable hangmanLetter
            Write-Host "The values are from 0 to 9!
            "
        }
        else {
            [int]$countString = 0
            #$emptyStringArray[0] = $hangmanLetter
            [int]$hangmanAnimalIndex = $hangmanAnimalLength - 1
            #Write-Host "the index" $hangmanAnimalIndex
            for ($i = 0; $i -lt $hangmanAnimalLength; $i++) {
                if ($hangmanAnimal[$i] -match $hangmanLetter) {
                    $emptyStringArray[$i] = $hangmanLetter
                    #Write-Host "value changed in empty string" $emptyStringArray
                    [int]$goodLetter = 1 
                }
                elseif ($countString -ge $hangmanAnimalIndex) {
                    [int]$countString = 0
                }
                $countString++
            }
            if ($goodLetter -eq 1) {
                Write-Host ""
                Write-Host "The letter $hangmanLetter was correct!
                "
                Write-Host "$emptyStringArray
                "
                [int]$goodLetter = 0
            }
            else {
                Write-Host "Wrong Letter!
                "
                Write-Host "$emptyStringArray
                "
                break
            }
            #Write-Host "in second while, " $animalSelected "and value "$emptyString
            #Write-Host "from while 2 , else" $hangmanLetter
            #Write-Host "The values are chars!"
            #break
            
        }
        #$emptyString = $emptyStringArray -join ""
        if (@(Compare-Object $hangmanAnimal $emptyStringArray -SyncWindow 0).Length -eq 0) {
            [int]$wonTheGame = 1
        }
    }
    if ($wonTheGame -eq 1) {
        Write-Host ""
        Write-Host "You won the game!
        "
        break
    }
    elseif ($countFails -eq 1) {
        Write-Host ""
        Write-Host "This was your $countFails atempt
        "
        Write-Host "
        ________
        |/     |
        |      
        |       
        |    
        |      
        |     / 
       /|\ 
      / | \ 
      "
    }
    elseif ($countFails -eq 2) {
        Write-Host ""
        Write-Host "This was your $countFails atempt
        "
        Write-Host "
        ________
        |/     |
        |      
        |      
        |    
        |      
        |     / \ 
       /|\ 
      / | \ 
      "
    }
    elseif ($countFails -eq 3) {
        Write-Host ""
        Write-Host "This was your $countFails atempt
        "
        Write-Host "
        ________
        |/     |
        |      
        |      
        |    / 
        |      
        |     / \ 
       /|\ 
      / | \ 
      "
    }
    elseif ($countFails -eq 4) {
        Write-Host ""
        Write-Host "This was your $countFails atempt
        "
        Write-Host "
        ________
        |/     |
        |      
        |       
        |    /   \ 
        |      
        |     / \ 
       /|\ 
      / | \ 
      "
    }
    elseif ($countFails -eq 5) {
        Write-Host ""
        Write-Host "This was your $countFails atempt
        "
        Write-Host "
        ________
        |/     |
        |      
        |      ^ 
        |    / | \ 
        |      ^
        |     / \ 
       /|\ 
      / | \ 
      "
    }
    elseif ($countFails -eq 6) {
        Write-Host ""
        Write-Host "This was your $countFails atempt
        "
        Write-Host "
        ________
        |/     |
        |      O
        |      ^ 
        |    / | \ 
        |      ^
        |     / \ 
       /|\ 
      / | \ 
      "
      Write-Host "You lost!
      "
      Write-Host "You got hanged!
      "
    }
    #Write-Host "wonthe game value" $wonTheGame
    #Write-Host "in while" $countFails
    $countFails++
}




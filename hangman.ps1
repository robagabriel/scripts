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
$emptyString = @()
for ($i = 0; $i -lt $hangmanAnimalLength; $i++) {
    $emptyString += "_"
}
Write-Host "Here you go!" 
Write-Host "
" $emptyString "
"
$countFails = 1
#Write-Host $countFails.GetType()
while ($countFails -le 6 ) {
    while ($animalSelected -notmatch $emptyString) {
        Write-Host "in second while, " $hangmanAnimal $emptyString
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
            Write-Host "from while 2 , else" $hangmanLetter
            Write-Host "The values are chars!"
            break
        }
    }
    Write-Host "in while" $countFails
    $countFails++
}




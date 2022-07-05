Write-Output "
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

$listOfAnimals = @("crocodile", "anaconda", "hippopotamus", "octopus", "alligator", "anteater", "baboon", "dolphin", "lizard", "peacock", "flamingo", "rooster", "gorilla", "buffalo", "caterpillar", "hamster", "chimpanzee", "cougar", "cheetah", "chicken", "elephant", "rattlesnake", "lobster")

$stringLentgh = $listOfAnimals.Count
#Write-Host $stringLentgh
Write-Host "before while" $hangmanWord
while ($null -eq $hangmanWord) {
    try {
        [int]$hangmanWord = Read-Host "Please enter the Hangman number that represents a word. The intervar is between 1 and" $listOfAnimals.Count
    }
    catch {
        Write-Host "Wrong value was given!"
        Write-Host "The value must be a number from 1 to " $stringLentgh "!"
    }
    
    if ($hangmanWord -ge $stringLentgh){
        $hangmanWord = $null
        Write-Host "in while, if statement, value of hangman " $hangmanWord
        Write-Host "Wrong value was given!"
        Write-Host "The value must be a number from 1 to " $stringLentgh "!"
    }
}
#($hangmanWord -notmatch '^[0-9]+$') -and  -and (-not ($hangmanWord -le stringLentgh)
#Write-Host $listOfAnimals.GetType()
#Write-Host $stringLentgh.GetType()
#Write-Host $hangmanWord.GetType()
Write-Host $hangmanWord
Write-Host $listOfAnimals[$hangmanWord - 1]
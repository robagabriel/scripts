$organization = Read-Host "Please enter your organization" 
Write-Host
$urlBase = "https://dev.azure.com/" + $organization
$urlResourceProjects = "projects"
$urlApiVersion = "api-version=6.0"
$urlProject = $urlBase + "/_apis/" + $urlResourceProjects + "?" +  $urlApiVersion
$accessToken = Read-Host "PLease enter your token" 
Write-Host
$user = ""
$token = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $accessToken)))
$header = @{authorization = "Basic $token"}
$projectDetails = Invoke-RestMethod -uri $urlProject -Method Get -ContentType "application/json" -headers $header
$projectCount = $projectDetails.count
Write-Host "There are the following projects:"
for ($i = 0; $i -lt $projectCount; $i++) {
    Write-Host $projectDetails.value[$i].name
}
Write-Host
$project =  Read-Host "Please enter your project from the list"
Write-Host

$urlResourceRepositories = "repositories"
$urlRepositories = $urlBase + "/" + $project + "/_apis/git/" + $urlResourceRepositories + "?" +  $urlApiVersion
$repositoriesDetails = Invoke-RestMethod -uri $urlRepositories -Method Get -ContentType "application/json" -headers $header
$repositoriesCound = $repositoriesDetails.count
Write-Host "PR title ; PR start ; PR duration ; Build PL ; Build number ; Queue start ; Queue duration(s) ; Build start ; Build duration(s) ; Build Message"
for ($z = 0; $z -lt $repositoriesCound; $z++) {
    $repoID = $repositoriesDetails.value[$z].id
    #Write-Host "repos id's:" $repoID 

    $urlResourcePullrequests = "pullrequests"
    $urlPullrequests = $urlBase + "/" + $project + "/_apis/git/" + $urlResourceRepositories + "/" + $repoID + "/" + $urlResourcePullrequests + "?searchCriteria.status=completed&" +  $urlApiVersion
    $repositoriesPullrequestsDetails = Invoke-RestMethod -uri $urlPullrequests -Method Get -ContentType "application/json" -headers $header
    $repositoriesPullrequestsCount = $repositoriesPullrequestsDetails.count
    for ($y = 0; $y -lt $repositoriesPullrequestsCount; $y++) {
        $pullrequestCreatebyID = $repositoriesPullrequestsDetails.value[$y].lastMergeCommit.commitId
        
        $urlResourceBuilds = "builds"
        $urlBuilds = $urlBase + "/" + $project + "/_apis/build/" + $urlResourceBuilds + "?reasonFilter=individualCI&" + $urlApiVersion
        $buildsDetails = Invoke-RestMethod -uri $urlBuilds -Method Get -ContentType "application/json" -headers $header
        $buildsCount = $buildsDetails.count
        for ($i = 0; $i -lt $buildsCount; $i++) {
            $buildSourceVersion = $buildsDetails.value[$i].sourceVersion
            
            if ($pullrequestCreatebyID -contains $buildSourceVersion) {
                #Write-Host "the biuld souce version:" $buildSourceVersion "and the pull request createby ID:" $pullrequestCreatebyID 
                
                $startMerge = $repositoriesPullrequestsDetails.value[$y].creationDate
                $endMerge = $repositoriesPullrequestsDetails.value[$y].closedDate
                $elapsedTimeMerge = (New-TimeSpan -Start $startMerge -End $endMerge).TotalSeconds
                $pullrequestTitle = $repositoriesPullrequestsDetails.value[$y].title
                
                
                $buildQueue = $buildsDetails.value[$i].queueTime
                $buildStart = $buildsDetails.value[$i].startTime
                $buildFinish = $buildsDetails.value[$i].finishTime
                $buildPipeline = $buildsDetails.value[$i].definition.name
                $buildNumber = $buildsDetails.value[$i].buildNumber
                $buildMessage = $buildsDetails.value[$i].triggerInfo."ci.message"
                $elapsedTimeRun = (New-TimeSpan -Start $buildStart -End $buildFinish).TotalSeconds
                $elapsedTimeQueue = (New-TimeSpan -Start $buildQueue -End $buildStart).TotalSeconds

                Write-Host $pullrequestTitle ";" $startMerge ";" $elapsedTimeMerge ";" $buildPipeline ";" $buildNumber ";" $buildQueue ";" $elapsedTimeQueue ";" $buildStart ";" $elapsedTimeRun ";" $buildMessage
            }
        }
    }
        
} 





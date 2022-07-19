# collectinf info regatding the organization 
$organization = Read-Host "Please enter your organization" 
Write-Host
$urlBase = "https://dev.azure.com/" + $organization
$urlResourceProjects = "projects"
$urlApiVersion = "api-version=6.0"

# creating the URL for the organization with the projects
$urlProject = $urlBase + "/_apis/" + $urlResourceProjects + "?" +  $urlApiVersion

# collecting the token
$accessToken = Read-Host "PLease enter your token" 
Write-Host
$user = ""
$token = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $accessToken)))
$header = @{authorization = "Basic $token"}

# collecting information from API calls
$projectDetails = Invoke-RestMethod -uri $urlProject -Method Get -ContentType "application/json" -headers $header
$projectCount = $projectDetails.count

# header for the list of projects
Write-Host "There are the following projects:"

# listing the projects
for ($i = 0; $i -lt $projectCount; $i++) {
    Write-Host $projectDetails.value[$i].name
}
Write-Host

# selecting a project
$project =  Read-Host "Please enter your project from the list"
Write-Host

# creating the URL for the repos
$urlResourceRepositories = "repositories"
$urlRepositories = $urlBase + "/" + $project + "/_apis/git/" + $urlResourceRepositories + "?" +  $urlApiVersion
$repositoriesDetails = Invoke-RestMethod -uri $urlRepositories -Method Get -ContentType "application/json" -headers $header
$repositoriesCound = $repositoriesDetails.count

# the hedear for the list of PR and pipelines
Write-Host "PR title ; PR start ; PR duration ; Build PL ; Build number ; Queue start ; Queue duration(s) ; Build start ; Build duration(s) ; Build Message"

# parsing all the repos
for ($z = 0; $z -lt $repositoriesCound; $z++) {

    # create the URL for the PR from a repo
    $repoID = $repositoriesDetails.value[$z].id
    $urlResourcePullrequests = "pullrequests"
    $urlPullrequests = $urlBase + "/" + $project + "/_apis/git/" + $urlResourceRepositories + "/" + $repoID + "/" + $urlResourcePullrequests + "?searchCriteria.status=completed&" +  $urlApiVersion
    $repositoriesPullrequestsDetails = Invoke-RestMethod -uri $urlPullrequests -Method Get -ContentType "application/json" -headers $header
    $repositoriesPullrequestsCount = $repositoriesPullrequestsDetails.count

    # parsing all the PR from a repo 
    for ($y = 0; $y -lt $repositoriesPullrequestsCount; $y++) {

        # creating the URL for the buils that are not manualy triggered 
        $pullrequestCreatebyID = $repositoriesPullrequestsDetails.value[$y].lastMergeCommit.commitId
        $urlResourceBuilds = "builds"
        $urlBuilds = $urlBase + "/" + $project + "/_apis/build/" + $urlResourceBuilds + "?reasonFilter=individualCI&" + $urlApiVersion
        $buildsDetails = Invoke-RestMethod -uri $urlBuilds -Method Get -ContentType "application/json" -headers $header
        $buildsCount = $buildsDetails.count

        # parsing all the builds
        for ($i = 0; $i -lt $buildsCount; $i++) {

            # compare the PR  created ID with the build source version to find the correlation between them
            $buildSourceVersion = $buildsDetails.value[$i].sourceVersion
            if ($pullrequestCreatebyID -contains $buildSourceVersion) {
                
                # collecting the info regarding the start,end of a PR and calculate the elapsed time
                $startMerge = $repositoriesPullrequestsDetails.value[$y].creationDate
                $endMerge = $repositoriesPullrequestsDetails.value[$y].closedDate
                $elapsedTimeMerge = (New-TimeSpan -Start $startMerge -End $endMerge).TotalSeconds
                $pullrequestTitle = $repositoriesPullrequestsDetails.value[$y].title
                
                # collecting the info regardint queue,start, finish odf a build and calculate the elapsed time
                $buildQueue = $buildsDetails.value[$i].queueTime
                $buildStart = $buildsDetails.value[$i].startTime
                $buildFinish = $buildsDetails.value[$i].finishTime
                $buildPipeline = $buildsDetails.value[$i].definition.name
                $buildNumber = $buildsDetails.value[$i].buildNumber
                $buildMessage = $buildsDetails.value[$i].triggerInfo."ci.message"
                $elapsedTimeRun = (New-TimeSpan -Start $buildStart -End $buildFinish).TotalSeconds
                $elapsedTimeQueue = (New-TimeSpan -Start $buildQueue -End $buildStart).TotalSeconds

                # print the resaults 
                Write-Host $pullrequestTitle ";" $startMerge ";" $elapsedTimeMerge ";" $buildPipeline ";" $buildNumber ";" $buildQueue ";" $elapsedTimeQueue ";" $buildStart ";" $elapsedTimeRun ";" $buildMessage
            }
        }
    }
        
} 





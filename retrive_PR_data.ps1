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

$urlResourcePipelines = "pipelines"
$urlPipelines = $urlBase + "/" + $project + "/_apis/" + $urlResourcePipelines + "?" +  $urlApiVersion
$pipelinesDetails = Invoke-RestMethod -uri $urlPipelines -Method Get -ContentType "application/json" -headers $header
$pipilineCount = $pipelinesDetails.count
Write-Host "Pipeline          PipelineID"
for ($i = 0; $i -lt $pipilineCount; $i++) {
    Write-Host $pipelinesDetails.value[$i].name  $pipelinesDetails.value[$i].id
    #Start-Sleep -Seconds 5
}
Write-Host
$pipelineName = Read-Host "Please enter your pipiline name from the list"
$pipelineID = Read-Host "And your pipiline id from the list"
Write-Host

$urlResourceRuns = "runs"
$urlPipelinesRuns = $urlBase + "/" + $project + "/_apis/" + $urlResourcePipelines + "/" + $pipelineID + "/" + $urlResourceRuns + "?" +  $urlApiVersion
$pipelinesRunsDetails = Invoke-RestMethod -uri $urlPipelinesRuns -Method Get -ContentType "application/json" -headers $header
$runCount = $pipelinesRunsDetails.count
Write-Host "Name        ID    Creation Date      Finished Date"
for ($i = 0; $i -lt $runCount; $i++) {
    Write-Host $pipelinesRunsDetails.value[$i].name $pipelinesRunsDetails.value[$i].id $pipelinesRunsDetails.value[$i].createdDate $pipelinesRunsDetails.value[$i].finishedDate
}
Write-Host
$runName = Read-Host "Please enter your pipiline run nume from the list"
Write-Host

$urlResourceBuilds = "builds"
$urlBuilds = $urlBase + "/" + $project + "/_apis/build/" + $urlResourceBuilds + "?reasonFilter=individualCI&buildNumber=" + $runName + "&" + $urlApiVersion
$buildsDetails = Invoke-RestMethod -uri $urlBuilds -Method Get -ContentType "application/json" -headers $header
$buildID = $buildsDetails.value.id
$buildQueue = $buildsDetails.value.queueTime
$buildStart = $buildsDetails.value.startTime
$buildFinish = $buildsDetails.value.finishTime
$buildMessage = $buildsDetails.value.triggerInfo."ci.message"
$elapsedTimeRun = (New-TimeSpan -Start $buildStart -End $buildFinish).TotalSeconds
$elapsedTimeQueue = (New-TimeSpan -Start $buildQueue -End $buildStart).TotalSeconds


if ($null -eq $buildID ) {
    Write-Host "The pipeline was triggered manually and the script will terminate now!"
    Write-Host 
}
else {
    $urlResourceRepositories = "repositories"
    $urlRepositories = $urlBase + "/" + $project + "/_apis/git/" + $urlResourceRepositories + "?" +  $urlApiVersion
    $repositoriesDetails = Invoke-RestMethod -uri $urlRepositories -Method Get -ContentType "application/json" -headers $header
    $repoID = $repositoriesDetails.value[0].id

    $urlResourcePullrequests = "pullrequests"
    $urlPullrequests = $urlBase + "/" + $project + "/_apis/git/" + $urlResourceRepositories + "/" + $repoID + "/" + $urlResourcePullrequests + "?searchCriteria.status=completed&" +  $urlApiVersion
    $repositoriesPullrequestsDetails = Invoke-RestMethod -uri $urlPullrequests -Method Get -ContentType "application/json" -headers $header
    $repositoriesPullrequestsCount = $repositoriesPullrequestsDetails.count
    for ($i = 0; $i -lt $repositoriesPullrequestsCount; $i++) {
        $pullrequestMessage = $repositoriesPullrequestsDetails.value[$i].completionOptions.mergeCommitMessage
        $buildMessageWild = "*" +  $buildMessage + "*"
        if ($pullrequestMessage -like $buildMessageWild) {
            $startMerge = $repositoriesPullrequestsDetails.value[$i].creationDate
            $endMerge = $repositoriesPullrequestsDetails.value[$i].closedDate
            $pullrequestTitle = $repositoriesPullrequestsDetails.value[$i].title
            $elapsedTimeMerge = (New-TimeSpan -Start $startMerge -End $endMerge).TotalSeconds
        }
    }
    Write-Host "This script will print out the data regarding a pull request  from the organizatione" $organization "and project" $project "."
    Write-Host "The pull request with the title," $pullrequestTitle ", has stared at " $startMerge "and run for " $elapsedTimeMerge "seconds."
    Write-Host "It triggered the pipiline" $pipelineName "with the job" $runName "that entered in queue at " $buildQueue "and waited for" $elapsedTimeQueue "seconds." 
    Write-Host "After the queue was finished the pipeline started at" $buildStart "and took" $elapsedTimeRun "seconds."
    Write-Host
}


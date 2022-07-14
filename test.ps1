$urlBase = "https://dev.azure.com/robagabriel"
$urlResourceProjects = "projects"
$urlApiVersion = "api-version=6.0"
$urlProject = $urlBase + "/_apis/" + $urlResourceProjects + "?" +  $urlApiVersion
Write-Host "The URL for the base is:" $urlBase
$accessToken = "wpdabc7zsig5dyopotyacai3yg5at5k23ttg6elo4dw5atqu47aq"
$user = ""
$token = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $accessToken)))
$header = @{authorization = "Basic $token"}
$projectDetails = Invoke-RestMethod -uri $urlProject -Method Get -ContentType "application/json" -headers $header
#Write-Host $projectDetails.GetType()
#Write-Host $urlProject.GetType()
<#
foreach($item in $projectDetails.all){
    $item
}
#>
#$projectDetails | ConvertTo-Json -Depth 4
$project =  $projectDetails.value.name
$projectID = $projectDetails.value.id
Write-Host "the project:" $project "the project id:" $projectID
$urlResourcePipelines = "pipelines"
$urlPipelines = $urlBase + "/" + $project + "/_apis/" + $urlResourcePipelines + "?" +  $urlApiVersion
Write-Host "The URL for the pipelines is:" $urlPipelines
$pipelinesDetails = Invoke-RestMethod -uri $urlPipelines -Method Get -ContentType "application/json" -headers $header
#$pipelinesDetails | ConvertTo-Json -Depth 7
$firstPipeline = $pipelinesDetails.value[0].name
$firstPipelineID = $pipelinesDetails.value[0].id
Write-Host "the first pipeline is:" $firstPipeline "and the id is:" $firstPipelineID
$secondPipeline = $pipelinesDetails.value[1].name
$secondPipelineID = $pipelinesDetails.value[1].id
Write-Host "the second pipeline is:" $secondPipeline "and the id is:" $secondPipelineID
$urlResourceRuns = "runs"
$urlPipelinesRuns = $urlBase + "/" + $project + "/_apis/" + $urlResourcePipelines + "/" + $firstPipelineID + "/" + $urlResourceRuns + "?" +  $urlApiVersion
Write-Host "The URL for the pipelines runs is:" $urlPipelinesRuns
$pipelinesRunsDetails = Invoke-RestMethod -uri $urlPipelinesRuns -Method Get -ContentType "application/json" -headers $header
$pipelinesRunsDetails[0].value[0] | ConvertTo-Json -Depth 9
$lastRun = $pipelinesRunsDetails[0].value[0].name 
$lastRunID = $pipelinesRunsDetails[0].value[0].id
$startRun = $pipelinesRunsDetails[0].value[0].createdDate
$endRun = $pipelinesRunsDetails[0].value[0].finishedDate
Write-Host "the run has the name:" $lastRun "and the ID:" $lastRunID 
Write-Host "The pipeline has started at:" $startRun "and finished at:" $endRun
$elapsedTimeRun = (New-TimeSpan -Start $startRun -End $endRun).TotalSeconds
Write-Host "The pipeline has run for:" $elapsedTimeRun "seconds."
<#
$urlResourceLogs = "logs"
$expand = "signedContent"
$urlRunLog = $urlBase + "/" + $project + "/_apis/" + $urlResourcePipelines + "/" + $firstPipelineID + "/" + $urlResourceRuns + "/" + $lastRunID + "/" + $urlResourceLogs + "?$expand&" +  $urlApiVersion
Write-Host "The URL for the pipelines run logs  is:" $urlRunLog
$pipelinesRunLogsDetails = Invoke-RestMethod -uri $urlRunLog -Method Get -ContentType "application/json" -headers $header
$pipelinesRunLogsDetails | ConvertTo-Json -Depth 9
#>
$urlResourceRepositories = "repositories"
$urlRepositories = $urlBase + "/" + $project + "/_apis/git/" + $urlResourceRepositories + "?" +  $urlApiVersion
Write-Host "The repositories url is:" $urlRepositories
$repositoriesDetails = Invoke-RestMethod -uri $urlRepositories -Method Get -ContentType "application/json" -headers $header
#$repositoriesDetails.value[0] | ConvertTo-Json -Depth 9
$repoName = $repositoriesDetails.value[0].name
$repoID = $repositoriesDetails.value[0].id
Write-Host "the repo name:" $repoName "and id:" $repoID
$urlResourcePullrequests = "pullrequests"
$urlPullrequests = $urlBase + "/" + $project + "/_apis/git/" + $urlResourceRepositories + "/" + $repoID + "/" + $urlResourcePullrequests + "?searchCriteria.status=completed&" +  $urlApiVersion
Write-Host "The repositories pullrequests url is:" $urlPullrequests
$repositoriesPullrequestsDetails = Invoke-RestMethod -uri $urlPullrequests -Method Get -ContentType "application/json" -headers $header
#$repositoriesPullrequestsDetails[0].value[0] | ConvertTo-Json -Depth 9 
$starMerge = $repositoriesPullrequestsDetails[0].value[0].creationDate
$endMerge = $repositoriesPullrequestsDetails[0].value[0].closedDate
Write-Host "The merge started at:" $starMerge "and finished at:" $endMerge
$elapsedTimeMerge = (New-TimeSpan -Start $starMerge -End $endMerge).TotalSeconds 
Write-Host "The merge took this much time:" $elapsedTimeMerge "seconds."
#https://dev.azure.com/{organization}/{project}/_apis/git/repositories/{repositoryId}/pullrequests?api-version=6.0
#https://dev.azure.com/robagabriel/devopscoursegabi/_apis/git/repositories/bfbc965a-b5c5-43f6-850b-2c34da3f8dd1/pullrequests?api-version=6.0


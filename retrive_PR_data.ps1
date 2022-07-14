$urlBase = "https://dev.azure.com/robagabriel"
$urlResourceProjects = "projects"
$urlApiVersion = "api-version=6.0"
$urlProject = $urlBase + "/_apis/" + $urlResourceProjects + "?" +  $urlApiVersion
$accessToken = "wpdabc7zsig5dyopotyacai3yg5at5k23ttg6elo4dw5atqu47aq"
$user = ""
$token = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user, $accessToken)))
$header = @{authorization = "Basic $token"}
$projectDetails = Invoke-RestMethod -uri $urlProject -Method Get -ContentType "application/json" -headers $header
$project =  $projectDetails.value.name
$projectID = $projectDetails.value.id
$urlResourcePipelines = "pipelines"
$urlPipelines = $urlBase + "/" + $project + "/_apis/" + $urlResourcePipelines + "?" +  $urlApiVersion
$pipelinesDetails = Invoke-RestMethod -uri $urlPipelines -Method Get -ContentType "application/json" -headers $header
$firstPipeline = $pipelinesDetails.value[0].name
$firstPipelineID = $pipelinesDetails.value[0].id
$secondPipeline = $pipelinesDetails.value[1].name
$secondPipelineID = $pipelinesDetails.value[1].id
$urlResourceRuns = "runs"
$urlPipelinesRuns = $urlBase + "/" + $project + "/_apis/" + $urlResourcePipelines + "/" + $firstPipelineID + "/" + $urlResourceRuns + "?" +  $urlApiVersion
$pipelinesRunsDetails = Invoke-RestMethod -uri $urlPipelinesRuns -Method Get -ContentType "application/json" -headers $header
$lastRun = $pipelinesRunsDetails[0].value[0].name 
$lastRunID = $pipelinesRunsDetails[0].value[0].id
$startRun = $pipelinesRunsDetails[0].value[0].createdDate
$endRun = $pipelinesRunsDetails[0].value[0].finishedDate
$elapsedTimeRun = (New-TimeSpan -Start $startRun -End $endRun).TotalSeconds
$urlResourceRepositories = "repositories"
$urlRepositories = $urlBase + "/" + $project + "/_apis/git/" + $urlResourceRepositories + "?" +  $urlApiVersion
$repositoriesDetails = Invoke-RestMethod -uri $urlRepositories -Method Get -ContentType "application/json" -headers $header
$repoName = $repositoriesDetails.value[0].name
$repoID = $repositoriesDetails.value[0].id
$urlResourcePullrequests = "pullrequests"
$urlPullrequests = $urlBase + "/" + $project + "/_apis/git/" + $urlResourceRepositories + "/" + $repoID + "/" + $urlResourcePullrequests + "?searchCriteria.status=completed&" +  $urlApiVersion
$repositoriesPullrequestsDetails = Invoke-RestMethod -uri $urlPullrequests -Method Get -ContentType "application/json" -headers $header
$starMerge = $repositoriesPullrequestsDetails[0].value[0].creationDate
$endMerge = $repositoriesPullrequestsDetails[0].value[0].closedDate
$elapsedTimeMerge = (New-TimeSpan -Start $starMerge -End $endMerge).TotalSeconds 



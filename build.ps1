param(
    $rule = "default"
)
<# NOTE: Update these variables to target different files with this script. #>
$MAIN = "src.app"
# ======================================================================== #
$CP_DELIM = ";"
if ( $IsMacOS -or $IsLinux ) {
    $CP_DELIM = ":" # changes to : for Mac or Linux
}
# Function to get the current branch name
function Get-CurrentBranch {
    $branch = git rev-parse --abbrev-ref HEAD
    return $branch
}
<# ======================================================================== #>
if ( $rule -eq "" -or $rule -eq "default" ) {

}

elseif ( $rule -eq "update" ) {
    git add .
    if ($args.Length -gt 0) {
        $commitMessage = $args[0]
    } else {
        $commitMessage = "updated"
    }
    git commit -m "$commitMessage"
    Write-Debug " ** committed ** "
    $currentBranch = Get-CurrentBranch
    git fetch origin $currentBranch
    git pull origin $currentBranch
    git push origin $currentBranch
    Write-Output " **Pushing to github in $currentBranch done..."
 
} 
elseif ( $rule -eq "run" ) {
    Write-Output "Running the application..."
    #dotnet run --project $MAIN
    #uvicorn main:app --host 127.0.0.1 --port 8000 --reload
    Write-Output " Coconut will be run. "

}
else {
    Write-Output "build: *** No rule to make target '$rule'.  Stop."
}


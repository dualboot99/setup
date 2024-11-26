Import-Module -Name PSReadLine
Import-Module -Name Terminal-Icons

oh-my-posh init pwsh --config $env:POSH_THEMES_PATH/jblab_2021.omp.json | Invoke-Expression


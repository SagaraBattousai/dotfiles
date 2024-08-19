

oh-my-posh init pwsh --config "~\dotfiles/oh-my-posh/themes/calo.omp.json" | Invoke-Expression
# Calo theme is based of of aliens but may switch to agnoster (with same edits)

# aliens.omp.json
# agnoster.omp.json
# paradox.omp.json
# M365Princess.omp.json

$env:POSH_GIT_ENABLED = $true

[Net.ServicePointManager]::SecurityProtocol =
    [Net.ServicePointManager]::SecurityProtocol -bor
    [Net.SecurityProtocolType]::Tls12


Set-Alias -Name timeit -Value Measure-Command
Set-Alias -Name man -Value Get-Help

function touch { #NewFile {
  param ($name)
  New-Item -Path $name -ItemType File
}

function Create-Source {
  param (
    [Parameter(Position=0, Mandatory)]
    [string]$Path,
    [Parameter(Position=1, Mandatory)]
    [string]$Filename
    )
    New-Item -itemtype File -Path "$Path$([System.IO.Path]::DirectorySeparatorChar)$Filename"
}

function Create-Header {
  param (
    [Parameter(Position=0, Mandatory)]
    [string]$Path,
    [Parameter(Position=1, Mandatory)] #TODO: make optional and use path if its empty
    [string]$Guard_Root, #Note: dotted "." Base header_guard i.e. project.module
    [Parameter(Position=2, Mandatory)]
    [string]$Filename
    )
  $header_guard = "__$($($Guard_Root -replace "\.", "_").ToUpper())_$([System.IO.Path]::GetFileNameWithoutExtension($Filename).ToUpper())_H__"

  $output_file = "$Path$([System.IO.Path]::DirectorySeparatorChar)$Filename"
  New-Item -itemtype File -Path $output_file
  "#ifndef $header_guard`n#define $header_guard`n`n#endif //$header_guard" | out-file $output_file -NoNewline
}




#Note: Old Create_header that uses path!
#function Old_Create-Header {
#  param (
#    [Parameter(Position=0, Mandatory)]
#    [string]$Path,
#    [Parameter(Position=1, Mandatory)]
#    [string]$Filename
#    )
#  $path_components = $Path.split([System.IO.Path]::DirectorySeparatorChar)
#  #TODO: Actually learn powershell scripting and clean this up!!
#  $header_guard = "__$((Join-String -InputObject $path_components[1..$($path_components.count -1)] -Separator "_").ToUpper())_$([System.IO.Path]::GetFileNameWithoutExtension($Filename).ToUpper())_H__"

#  $output_file = "$Path$([System.IO.Path]::DirectorySeparatorChar)$Filename"
#  New-Item -itemtype File -Path $output_file
#  echo "#ifndef $header_guard" >> $output_file
#  echo "#define $header_guard" >> $output_file
#  echo "`n`n#endif" >> $output_file
#}
#Set-Alias -Name touch -Value NewFile

################### Set Get-ChildItem Colours #######################
$PSStyle.FileInfo.Directory = $PSStyle.Foreground.Blue 
$PSStyle.FileInfo.SymbolicLink = $PSStyle.Foreground.BrightCyan 
$PSStyle.FileInfo.Executable = $PSStyle.Foreground.BrightRed

## Image Extensions
$PSStyle.FileInfo.Extension[".png"] = $PSStyle.Foreground.Purple

## Markdown Extensions
$PSStyle.FileInfo.Extension[".md"] = $PSStyle.Foreground.Green
$PSStyle.FileInfo.Extension[".rst"] = $PSStyle.Foreground.Green

## Script Extensions #ps1 defaults to yellow (orange) so lets make the
## rest follow suit
$PSStyle.FileInfo.Extension[".py"] = $PSStyle.Foreground.Yellow
$PSStyle.FileInfo.Extension[".bat"] = $PSStyle.Foreground.Yellow


function New-Link {
  param (
    [Parameter(Position=0, Mandatory)]
    [string]$Path,
    [Parameter(Position=1, Mandatory)]
    [string]$Target,
    [switch]$Hard
    )
    if ($Hard) {$LinkType = "HardLink"}
    else {$LinkType = "SymbolicLink"}
    new-item -itemtype $LinkType -Path $Path -target $Target
}

Set-Alias -Name nl -Value New-Link
Set-Alias -Name ln -Value New-Link



# Import-Module PSColor

# Piping to fw removes colours so we'll ignore for now!
#Remove-Alias -Name ls -Force -ErrorAction ignore #Incase aliased
#function ls {
#  # param ([int]$Column = 5) #<- causes issues with surplying a path
#  #Paramless for now, will forward later
#  #$count = (Get-ChildItem | 
#            #Tee-Object -variable ls_output | 
#            #measure-object).count
#  #if ($count % .....
#  #echo $ls_output | fw
#  $Column = 5
#  Get-ChildItem | fw -Column $Column
#}

###############################################
##################COLORISE LS##################
###############################################



#function global:ls {
#  $args = (Format-WslPaths $args)
  
#  # $base_arg = ($LS_COLORS, $EXPORT_LS_COLORS, "ls --color=auto") -join "; "
#  #
#  # VV for when colors stop (uncomment to fix me thinks)
#  # wsl.exe "export" $LS_COLORS
        
#  Call-WslCommand "ls" $input $args "--color=auto" #$base_arg
#  #param([string]$fn_name, $piped, $arguments, $defaultArgs)
#  # if ($input.MoveNext()) {
#  #   $input.Reset()
#  #   $input | wsl.exe "ls" "--color=auto" ($args -split $ARG_REGEX)
#  # } else {
#  #   wsl.exe "ls" "--color=auto" ($args -split $ARG_REGEX)
#  # }
#}

Remove-Alias tree -Force -ErrorAction Ignore
function global:tree {
  $args = (Format-WslPaths $args)
  
  $base_arg = ($LS_COLORS, $EXPORT_LS_COLORS, "tree") -join "; "

  # Call-WslCommand eval $input $args $base_arg
  #param([string]$fn_name, $piped, $arguments, $defaultArgs)
  if ($input.MoveNext()) {
    $input.Reset()
    $input | wsl.exe eval $base_arg ($args -split $ARG_REGEX)
  } else {
    wsl.exe eval $base_arg ($args -split $ARG_REGEX)
  }
}

###############################################
#######GENERAL UNIX COMMANDS FOR WINDOWS#######
###############################################
#Removed cp, all the unix commands are now weirdly slow on powershell
#WTF LS NOW SEEMS TO WORK :'( WHYYYYY
# Removed ls/mv due to things like looking in different drives abd the crazy lag
$unixCommands = #"ls", #"cat", 
                "awk", "base64", `
                "chmod", "curl", "diff", "du", `
                "find", "grep", "gzip", "head", "hexdump", "less", `
                #"mv",
                "pwd", "sed", "seq", "tail", "tree", "umask", "wc"

$WslDefaultParameters = @{
  Disabled = $false;
  grep = "--color=auto"
  #ls = "--color=auto"
  base64 = "--wrap=0"
  }

# Can't quite remember why we do this quote check or what cases it needs but
# We've now fixed it for the "\ " case (aka backslash space)
$ARG_REGEX = '(?<!\\) +(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)' 

#Cant see a smart way around the whole Invoke-Expression
$unixCommands | ForEach-Object { Invoke-Expression @"
  Remove-Alias $_ -Force -ErrorAction Ignore
    function global:$_ {
     
      if (`$args.Count -gt 0) {
        `$args = (Format-WslPaths `$args)
      }
  
      `$defaultArgs = ((`$WslDefaultParameters.$_ -split ' '), "").``
                        get([bool]`$WslDefaultParameters.Disabled)

      Call-WslCommand $_ `$input `$args `$defaultArgs
    }
"@
}

function global:Call-WslCommand {
  param([string]$fn_name, $piped, $arguments, $defaultArgs)

  if ($piped.MoveNext()) {
    $piped.Reset()
    $piped | wsl.exe $fn_name $defaultArgs ($arguments -split $ARG_REGEX)
  } else {
    wsl.exe $fn_name $defaultArgs ($arguments -split $ARG_REGEX)
  }


}

function global:Format-WslArgument {
  param([string]$arg, [bool]$interactive)
  if ($interactive -and $arg.Contains(" ")) {
    return "'$arg'"
  } else {
    # "(?<!\\) " means that an already backslash escaped space will not
    # be backslash escaped again, a.k.a trust the user.
    return ($arg -replace "(?<!\\) ", "\ ") -replace `
            "([()|])", ('\$1', '`$1')[$interactive] 
  }
}

function global:Path-Separator {
  param($path)
  # (?! ) means dont convert if followed by a space since \ is escaping the space.
  return $path -replace "\\(?! )", "/" 
}

function global:Format-WslPaths {
  param($paths)

  for ($i = 0; $i -lt $paths.Count; $i++) {
    # If a path is absolute with a qualifier (e.g. C:), 
    # run it through wslpath to map it to the appropriate mount point.
    if (Split-Path $paths[$i] -IsAbsolute -ErrorAction Ignore) {
      $paths[$i] = Format-WslArgument (wsl.exe wslpath (Path-Separator $paths[$i]))

      # If a path is relative, the current working directory will be
      # translated to an appropriate mount point, so just format it.
    } elseif (Test-Path $paths[$i] -IsValid -ErrorAction Ignore) {
        $paths[$i] = Format-WslArgument (Path-Separator $paths[$i]) #($paths[$i] -replace "\\", "/")
    }
  }

  return $paths
}

# Set-Variable -Name "EXPORT_LS_COLORS" -Value "export LS_COLORS"

Set-Variable -Name "LS_COLORS" -Value ("LS_COLORS='rs=0:di=01;34:" `
+"ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:" `
+"or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=04;34:" `
+"st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:" `
+"*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:" `
+"*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:" `
+"*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:" `
+"*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:" `
+"*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:" `
+"*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:" `
+"*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:" `
+"*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:" `
+"*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:" `
+"*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:" `
+"*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:" `
+"*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:" `
+"*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:" `
+"*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:" `
+"*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:" `
+"*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:" `
+"*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:" `
+"*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:" `
+"*.spx=00;36:*.xspf=00;36:'")

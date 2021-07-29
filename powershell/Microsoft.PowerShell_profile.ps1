
Set-Alias -Name timeit -Value Measure-Command

function NewFile {
  param ($name)
  New-Item -Path $name -ItemType File
}

Set-Alias -Name touch -Value NewFile



###############################################
##################COLORISE LS##################
###############################################
Remove-Alias ls -Force -ErrorAction Ignore
function global:ls {
  $args = (Format-WslPaths $args)
  #Older slowerway to generate colours via eval, but slow because eval is slow
  #base_arg = "`$(dircolors -b ~/.dircolors); ls --color=auto"
  
  $base_arg = ($LS_COLORS, $EXPORT_LS_COLORS, "ls --color=auto") -join "; "
        
  Call-WslCommand eval $input $args $base_arg
}

Remove-Alias tree -Force -ErrorAction Ignore
function global:tree {
  $args = (Format-WslPaths $args)
  
  $base_arg = ($LS_COLORS, $EXPORT_LS_COLORS, "tree") -join "; "

  Call-WslCommand eval $input $args $base_arg
}

###############################################
#######GENERAL UNIX COMMANDS FOR WINDOWS#######
###############################################
$unixCommands = "awk", "base64", "cat", "chmod", "cp", "curl", "diff", "du", `
                "grep", "gzip", "head", "less", "man", "mv", "pwd", "sed", `
                "seq", "tail", "umask", "wc"

$WslDefaultParameters = @{
  Disabled = $false;
  grep = "--color=auto"
  base64 = "--wrap=0"
  }

# Unix Regex to keep quoted arguments
# Currently can't workout how to do both " and ' but one day ....
# Adendum: screws up paths with spaces
# TODO: Work out why I needed this!
$ARG_REGEX = ' +(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)' 

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
    $piped | wsl.exe $fn_name $defaultArgs $arguments #($arguments -split $ARG_REGEX)
  } else {
    wsl.exe $fn_name $defaultArgs $arguments #($arguments -split $ARG_REGEX)
  }


}

function global:Format-WslArgument {
  param([string]$arg, [bool]$interactive)
  if ($interactive -and $arg.Contains(" ")) {
    return "'$arg'"
  } else {
    return ($arg -replace " ", "\ ") -replace `
            "([()|])", ('\$1', '`$1')[$interactive] 
  }
}

function global:Format-WslPaths {
  param($paths)

  for ($i = 0; $i -lt $paths.Count; $i++) {
    # If a path is absolute with a qualifier (e.g. C:), 
    # run it through wslpath to map it to the appropriate mount point.
    if (Split-Path $paths[$i] -IsAbsolute -ErrorAction Ignore) {
      $paths[$i] = Format-WslArgument (wsl.exe wslpath ($paths[$i] -replace "\\", "/"))

      # If a path is relative, the current working directory will be
      # translated to an appropriate mount point, so just format it.
    } elseif (Test-Path $paths[$i] -IsValid -ErrorAction Ignore) {
        $paths[$i] = Format-WslArgument ($paths[$i] -replace "\\", "/")
    }
  }

  return $paths
}

Set-Variable -Name "EXPORT_LS_COLORS" -Value "export LS_COLORS"

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

# === Class: windows_git
#
# This module installs Git on Windows systems. It also adds an entry to the
# PATH environment variable.
#
# === Parameters
#
# [*url*]
#   HTTP url where the installer is available. It defaults to main site.
# [*package*]
#   Package name in the system.
# [*file_path*]
#   This parameter is used to specify a local path for the installer. If it is
#   set, the remote download from $url is not performed. It defaults to false.
#
# === Examples
#
# class { 'windows_git': }
#
# class { 'windows_git':
#   $url     => 'http://192.168.1.1/files/git.exe',
#   $package => 'Git version 1.8.0-preview201221022',
# }
#
# === Authors
# 
#
class windows_git (
  $url       = $::windows_git::params::url,
  $file_path = false,
) inherits windows_git::params {
  if $::chocolatey {
    Package { provider => chocolatey }
    $package   = 'git'
  } else {
    $package   = $::windows_git::params::package
    Package{
        source          => $git_installer_path,
        install_options => ['/VERYSILENT','/SUPPRESSMSGBOXES','/LOG'],
        provider        => windows,
    }

    if $file_path {
      $git_installer_path = $file_path
    } else {
      $git_installer_path = "${::temp}\\${package}.exe"
      windows_common::remote_file{'Git':
        source      => $url,
        destination => $git_installer_path,
        before      => Package[$package],
      }
    }
  }
  package { $package:
    ensure          => installed,
  #  source          => $git_installer_path,
  #  install_options => ['/VERYSILENT','/SUPPRESSMSGBOXES','/LOG'],
  }

  if $::architecture == 'x64' {
    $git_path = 'C:\Program Files (x86)\Git\cmd'
  } else {
    $git_path = 'C:\Program Files\Git\cmd'
  }
  windows_path { $git_path:
    ensure  => present,
    require => Package[$package],
  }
}

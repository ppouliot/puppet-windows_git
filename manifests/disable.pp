# === Class: windows_git::disable
#
# This class removes the installed components.

class windows_git::disable (
  $package   = $::windows_git::params::package,
) inherits windows_git::params {

  package { $package:
    ensure  => absent,
  }

  windows_path { $::git_path:
    ensure  => absent,
  }

  file { "${::temp}/${package}.exe":
    ensure  => absent,
  }

}

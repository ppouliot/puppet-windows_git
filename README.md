puppet-windows_git
==============
This module installs Git on Windows machines, adding the binary to the PATH environemnt variable.

Basic usage
-----------
The basic scenario allows the user to install Git fetching the installer from the main site:

    class { 'windows_git': }

It is also possible to specify an alternative remote URL:

    class { 'windows_git':
      $url => 'http://192.168.1.1/files/git_installer.exe',
    }

Finally, it is also possible to specify a local path where the installer is available:

    class { 'windows_git':
      $file_path => 'F:/Shared/Software/git.exe',
    }

Contributors
------------

License
-------
 

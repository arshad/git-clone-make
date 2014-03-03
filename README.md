git-clone-make
---

A git command that parses a Drupal make file and clones projects.

### Installation

  Download script and place in your PATH

    $ git clone https://github.com/arshad/git-clone-make.git
    $ cp git-clone-make /usr/local/bin

  Make script executable

    $ sudo chmod +x /usr/local/bin/git-clone-make

### Usage

  cd to your distro root

    $ cd distro

  Run command to clone projects
  
    $ git clone-make path/to/make/file.make drupal_org_git_username
    $ git clone make drupal-org.make arshad

## Assumptions

The script assumes that projects are defined in your make file as follows:

    projects[PROJECT_NAME][type] = module
    projects[PROJECT_NAME][download][type] = git
    projects[PROJECT_NAME[download][revision] = 94056c2
    projects[PROJECT_NAME][download][branch] = 7.x-1.x
    projects[PROJECT_NAME][subdir] = contrib

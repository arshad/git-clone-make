#!/usr/bin/env ruby

projects = {}
current_project_name = ''

File.open('restaurant.make') do |f|
  f.each_line do |line|
    # Get the project name.
    if match = line.match(/^projects\[([\w]*)\]/i)
      name = match[1].to_s
    end

    # Determine if this is a new project.
    if name && name != current_project_name
      current_project_name = name
      projects[current_project_name] = { :type => '', :download_type => '', :revision => '', :branch => '', :subdir => '' }
    end

    # Get project type
    if match = line.match(/^projects\[[\w]*\]\[type\][\s]*=[\s]*([a-z]*)$/i)
      projects[current_project_name][:type] = match[1]
    end

    # Get project download type.
    if match = line.match(/^projects\[[\w]*\]\[download\]\[type\][\s]*=[\s]*(...)$/i)
      projects[current_project_name][:download_type] = match[1]
    end

    # Get project revision.
    if match = line.match(/^projects\[[\w]*\]\[download\]\[revision\][\s]*=[\s]*([\S]*)/i)
      projects[current_project_name][:revision] = match[1]
    end

    # Get project branch.
    if match = line.match(/^projects\[[\w]*\]\[download\]\[branch\][\s]*=[\s]*([\S]*)/i)
      projects[current_project_name][:branch] = match[1]
    end

    # Get project subdir
    if match = line.match(/^projects\[[\w]*\]\[subdir\][\s]*=[\s]*([a-z]*)$/)
      projects[current_project_name][:subdir] = match[1]
    end
  end
end

projects = projects.select { |name, project| project[:download_type] == 'git' }

projects.each do |name, project|
  # Build a git clone command.
  command = "git clone"

  # Specify branch if set.
  command += (project[:branch]) ? " --branch #{project[:branch]}" : '';

  # Determine where to put code
  if project[:type] == 'module'
    subdir = (project[:subdir]) ? "#{project[:subdir]}/" : ''
    destination = "modules/#{subdir}#{name}"
  elsif project[:type] == 'theme'
    destination = "themes/#{name}"
  end

  # Add url and destination.
  command += " arshad@git.drupal.org:project/#{name}.git #{destination}"

  puts command
end

# puts projects

# repos.each do |url, destination|
#   # Get the name of the repo to clone from url.
#   name = url.scan(/([\w\-]*).git$/).last.first

#   # Call git clone.
#   system("git clone #{url} #{destination}/#{name}");
# end

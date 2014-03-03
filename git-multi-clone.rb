#!/usr/bin/env ruby

repos = Hash[*File.read('restaurant.repo').split(/[, \n]+/)]

repos.each do |url, destination|
  # Get the name of the repo to clone from url.
  name = url.scan(/([\w\-]*).git$/).last.first

  # Call git clone.
  system("git clone #{url} #{destination}/#{name}");
end

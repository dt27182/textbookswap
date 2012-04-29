desc "Get the courses from the Berkeley website"
task :get_courses => :environment do
  Course.get_courses_for(ENV[SEMESTER], ENV[YEAR])
end

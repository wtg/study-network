namespace :db do
  desc "TODO"
  task populate_courses: :environment do
    require 'nokogiri'
    require 'open-uri'

    puts "Course Schedule URL: "
    schedule_url = STDIN.gets.chomp
    puts "Getting Courses from " + schedule_url

    # Open course schedule based on input url
    page = Nokogiri::HTML(open(schedule_url))

    # Crawl page for list of all departments (h4's)
    @departments = Array.new
    page.css('h4').each do |dept|
      @departments << dept.content
    end

    # Initialize arrays used to store courses 
    @classes = Array.new
    dept_classes = Array.new
    a_class = Array.new

    # Initialize counter to be used in progress % output
    @num_classes = 0

    # Crawl the page for each table 
    #  (a single department's courses)
    page.search('table').each do |table|
      # Crawl each table for single courses 
      #   (all courses in a single department)
      table.search('tr').each do |tr|
        if tr.search('td')[0] and tr.search('td')[1]
          if tr.search('td')[1].text.strip != 'NOTE:'
            # First cell contains CRN, Dept Abbrev, and Section
            a_class << tr.search('td')[0].text.strip
            # Second cell contains Course Title
            a_class << tr.search('td')[1].text.strip
          end
        end
        # Add single class array to new array of Department's Classes
        dept_classes << a_class.dup
        # Clear single class array for reuse
        a_class.clear
        # Increment num_courses
        @num_classes += 1
      end
      # Add a Department's Classes (array) to an array of All Classes
      @classes << dept_classes.dup
      dept_classes.clear
    end

    # Keep track of our progress when seeding courses table
    @progress_counter = 1
    # For each department table's classes
    @classes.each do |dept|
      # For each class in each department table
      dept.each do |cl|
        if cl[0].to_s != "" and cl[1].to_s != ""
          # Split details on CRN from 
          #   Course Title, Dept Abbrev, Section, & Level
          crn_course_sec = cl[0].to_s.split()
          course_crn = crn_course_sec[0]
          # Split apart details on 
          #  Course Title, Dept Abbrev, Section, & Level
          course_sec = crn_course_sec[1].split("-")
          course_abrev = course_sec[0]
          course_level = course_sec[1]
          course_sec = course_sec[2]
          # Create our new course based on above results
          Course.create(title: cl[1], crn: course_crn, abrev_name: course_abrev)
          # Show Progress Counter for Rake Task
          print " "*20 + "\r"
          print ((@progress_counter.to_f/@num_classes.to_f)*100.0).to_s + "%"
          print "\r"
          STDOUT.flush
          @progress_counter += 1
        end
      end
    end

    print "\nFinished adding courses from " + schedule_url
    STDOUT.flush
  end

end

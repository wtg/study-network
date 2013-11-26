class CoursesController < ApplicationController

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    registered_students = Registration.where(course_id: params[:id])
    @users = Array.new
    if registered_students.length > 0 
      registered_students.each do |rs|
        @users << User.find(rs.user_id)
      end
    end
  end

  def new
    require 'nokogiri'
    require 'open-uri'

    schedule_url = 'http://sis.rpi.edu/reg/zs201401.htm'

    page = Nokogiri::HTML(open(schedule_url))

    @departments = Array.new
    page.css('h4').each do |dept|
      @departments << dept.content
    end

    @classes = Array.new
    dept_classes = Array.new
    a_class = Array.new

    page.search('table').each do |table|
      table.search('tr').each do |tr|
        if tr.search('td')[0] and tr.search('td')[1]
          if tr.search('td')[1].text.strip != 'NOTE:'
            a_class << tr.search('td')[0].text.strip
            a_class << tr.search('td')[1].text.strip
          end
        end
        dept_classes << a_class.dup
        a_class.clear
      end
      @classes << dept_classes.dup
      dept_classes.clear
    end

    @classes.each do |dept|
      dept.each do |cl|
        if cl[0].to_s != "" and cl[1].to_s != ""
          crn_course_sec = cl[0].to_s.split()
          course_crn = crn_course_sec[0]
          course_sec = crn_course_sec[1].split("-")
          course_abrev = course_sec[0]
          course_level = course_sec[1]
          course_sec = course_sec[2]
          Course.create(title: cl[1], crn: course_crn, 
            abrev_name: course_abrev, level: course_level, 
            section: course_sec)
        end
      end
    end
  end

end
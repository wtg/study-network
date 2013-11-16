class CoursesController < ApplicationController

  def index
    @courses = Course.all
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
        @course = Course.new(crn_course_sec: cl[0], title: cl[1])
        @course.save
      end
    end

    redirect_to 'courses_path'

  end

end
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

    page.search('table').each do |table|
      table.search('td').each do |td|
        dept_classes << td.content
      end
      @classes << dept_classes.dup
      dept_classes.clear
    end
  end

end
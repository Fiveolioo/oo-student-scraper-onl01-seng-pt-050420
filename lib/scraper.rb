require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    data = Nokogiri::HTML(open(index_url))
    students = data.css(".student-card").collect do |student|
      {
        :location => student.css(".student-location").text,
        :name => student.css(".student-name").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = Nokogiri::HTML(open(profile_url))
    info = {}
    student.css("a").each_with_index do |social, idx|
      if idx != 0
        link = social.attribute("href").value
        if link.include?("twitter")
          info[:twitter] = link
        elsif link.include?("linkedin")
          info[:linkedin] = link
        elsif link.include?("github")
          info[:github] = link
        else
          info[:blog] = link
        end
      end
    end
    info[:profile_quote] = student.css(".profile-quote").text
    info[:bio] = student.css("p").text
    info
  end

end

 
# # # projects: kickstarter.css("li.project.grid_4")
# # # title: project.css("h2.bbcard_name strong a").text
# # # image link: project.css("div.project-thumbnail a img").attribute("src").value
# # # description: project.css("p.bbcard_blurb").text
# # # location: project.css("ul.project-meta span.location-name").text
# # # percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
 
# # def create_project_hash
# #   html = File.read('fixtures/kickstarter.html')
# #   kickstarter = Nokogiri::HTML(html)
 
# #   projects = {}
 
# #   kickstarter.css("li.project.grid_4").each do |project|
# #     title = project.css("h2.bbcard_name strong a").text
# #     projects[title.to_sym] = {
# #       :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
# #       :description => project.css("p.bbcard_blurb").text,
# #       :location => project.css("ul.project-meta span.location-name").text,
# #       :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
# #     }
# #   end
 
# #   # return the projects hash
# #   projects
# # end

# # Write your code here

# require 'net/http'
# require 'open-uri'
# require 'json'
# class GetRequester 
 
#   def initialize(url)
#     @url = url 
#   end 
  
#   def get_response_body
#     uri = URI.parse(@url)
#     response = Net::HTTP.get_response(uri)
#     response.body
#   end
  
#   def parse_json
#       data = JSON.parse(self.get_response_body)
#       data
#   end
# end



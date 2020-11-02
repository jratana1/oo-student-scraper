require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("#{index_url}"))
    profiles = []

    doc.css('div.student-card').each do |profile|
      profiles << {
        :name => profile.css("h4").text ,
        :location => profile.css("p").text,
        :profile_url => profile.css("a").attribute("href").value}
      end
      profiles
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open("#{profile_url}"))
    
    
    profile = {
      :profile_quote => doc.css("div.profile-quote").text ,
      :bio => doc.css("div.description-holder p").text
    }

    doc.css("div.social-icon-container a").each {|box|
          if box.attribute("href").value.include?("twitter")
              profile[:twitter] = box.attribute("href").value
          elsif box.attribute("href").value.include?("linkedin")
            profile[:linkedin] = box.attribute("href").value
          elsif box.attribute("href").value.include?("github")
            profile[:github] = box.attribute("href").value
          else
            profile[:blog] = box.attribute("href").value
          end
        }
        profile
  end

end
# profile[:twitter] = doc.css("div.social-icon-container a")[0].attribute("href").value ,
# :linkedin => doc.css("div.social-icon-container a")[1].attribute("href").value ,
# :github => doc.css("div.social-icon-container a")[2].attribute("href").value ,
# :blog => doc.css("div.social-icon-container a")[3].attribute("href").value,

          # name = doc.css('div.student-card')[0].css("h4").text
          # location = doc.css('div.student-card')[0].css("p").text
          # profile url= doc.css('div.student-card)[0].css("a").attribute("href").value

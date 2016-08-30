require 'nokogiri'
require 'open-uri'
require 'byebug'
# require_relative '../../app/models/sample_sale.rb'

class SampleSaleScraper

  ATTR = ["About","Dates","Hours","Address","Brand", "About"] 
  
  def get_page
    doc = Nokogiri::HTML(open("http://apps.voxmedia.com/at/racked-sample-sale-test/?initialWidth=596&amp;childId=racked-sample-sale-test__graphic&amp;parentUrl=http%3A%2F%2Fny.racked.com%2F2016%2F5%2F24%2F11723266%2Fnyc-sample-sales-list"))

    text = doc.css("script")[6].content.split('= [')[1].tr!('"',"").split('},{')

    sales = []
    text.collect do |info|  
      info.delete!("{")
      info.delete!("}]")
      info.gsub!(/:null/,"")
      sales << info
    end

    new_sale = [] 
    sales.collect do |sale|  
      final = {}
      # binding.pry
      i = 0
      while i < 5 do
        string = sale.match(/#{ATTR[i]}.*?(?=#{ATTR[i+1]}|$)/).to_s[0..-2]
        array = string.split(ATTR[i])
        final[ATTR[i].downcase] = array[1][1..-1]
        i += 1
      end
       new_sale << final
    end
      new_sale
  end
 
end
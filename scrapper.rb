require 'open-uri'
require 'nokogiri'
class Goclecd
    def self.getPrice(url)
        html = Nokogiri::HTML(open(url).read)
        all_price = Nokogiri::HTML.parse(html.xpath("//*[contains(@class, \'price-value\')]").to_s)
        prices = Array.new
        all_price.content.to_s.split(" ") do |l|
            prices << l.to_s[0..3]
        end

        return prices[0..2]
    end

    def self.getWebSite(url)
        html = Nokogiri::HTML(open(url).read)
        all_site = Nokogiri::HTML.parse(html.xpath("//*[contains(@class, \'offers-merchant-name\')]").to_s)
        sites = Array.new
        all_site.content.split("\n") do |s|
            if ( s.tr(' ','') != '')
                sites << s.tr(' ','')
            end
        end
        return sites[0..5]
    end
end

# puts Goclecd.getWebSite("https://www.goclecd.fr/acheter-ghost-recon-wildlands/")
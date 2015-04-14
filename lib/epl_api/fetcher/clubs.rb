require 'nokogiri'
require 'open-uri'

module EplApi
  module Fetcher
    module Clubs
      INDEX_URI = 'http://www.premierleague.com/en-gb/clubs/index.all-seasons.html'

      def index

      end

      class Scraper

        def initialize
          @doc = Nokogiri::HTML(open(INDEX_URI))
        end

        def parse
          @doc.css('table.leagueTable.all-seasons tbody tr').map do |club_doc|
            {
              :id =>
                club_doc.at_css('.col-club a').attr('href').split('/').last,
              :name => club_doc.at_css('.col-club a').content,
              :link =>
                "http://www.premierleague.com"\
                "#{club_doc.at_css('.col-club a').attr('href')}"
            }
          end
        end

      end

    end
  end
end

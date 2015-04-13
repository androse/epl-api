module EplApi
  module Fetcher
    module Results
      module_function

      INDEX_URI = 'http://www.premierleague.com/pa-services/api/football/desktop/competition/fandr/currentResultsComp/%7BapiKey%7D/query.json'

      def index(options = {})
        default_options = {
          :season_id => 2014,
          :team_id => nil
        }
        options = default_options.merge(options)

        uri = INDEX_URI
        params = {
          competition_id: 8,
          season_id: options[:season_id]
        }

        HttpClient.get(uri, params)["matches"]
      end
    end
  end
end

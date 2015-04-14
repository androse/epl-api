module EplApi
  class Fetcher

    attr_reader :base_url

    def initialize(options = {})
      @competition_id = options[:competition_id] || 8
      @season_id = options[:season_id] || 2014
      @base_url = 'http://live.premierleague.com/syndicationdata'
    end

    def fetch(options, data_name)
      url = format_url(options, data_name)
      HttpClient.get(url)
    end

    def format_url(options, data_name)
      [@base_url, format_options(options), data_name].join('/')
    end

    def format_options(options)
      all_options = {
        competition_id: @competition_id, season_id: @season_id
      }.merge(options)

      string_options = []
      all_options.each do |key, value|
        string_options.push("#{Utils.camelize(key.to_s)}=#{value}")
      end

      string_options.join('/')
    end

  end
end

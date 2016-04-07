require 'genesis_client/devices'
# require 'genesis_client/remote_actions'
require 'faraday_middleware'

module GenesisClient
  class Client
    def initialize(options = {})
      @endpoint = options[:endpoint].to_s
      @token = options[:token].to_s
      raise ArgumentError, ":endpoint can't be blank" if @endpoint.empty?
      raise ArgumentError, ":token can't be blank" if @token.empty?
    end

    include GenesisClient::Devices
    # include GenesisClient::RemoteActions

    private

    def get(path, options = {})
      request(:get, path, options)
    end

    def post(path, data = {})
      request(:post, path, data)
    end

    def put(path, data = {})
      request(:put, path, data)
    end

    def request(method, path, data = {})
      res = connection.send(method, "api/#{path}", data)
      if res.success? && !res.body.empty? && res.body != ' '
        res.body
      else
        res
      end
    end

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new @endpoint do |f|
        f.request :json
        f.headers[:user_agent] = GenesisClient::USER_AGENT
        f.headers['Token'] = @token

        # f.response :logger
        f.response :mashify
        f.response :json, content_type: /\bjson$/

        f.adapter Faraday.default_adapter
      end
    end
  end
end

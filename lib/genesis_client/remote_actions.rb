module GenesisClient
  module RemoteActions
    # Receive a list of all Devices.
    #
    # @return [Array<Hashie::Mash>] Array of hashes representing remote actions.
    # @example
    #   client = GenesisClient::Client.new
    #   client.remote_actions
    def remote_actions(zone, status = 'created')
      filters = {
        zone: zone,
        status: status
      }
      get('/remote_actions', filters)['remote_actions']
    end
    alias list_remote_actions remote_actions

    # Receive a single Remote Action.
    #
    # @return [Hashie::Mash] Hash representing the remote action.
    # @param id [String, Integer] The id of the remote action
    # @example
    #   client = GenesisClient::Client.new
    #   client.remote_action('234')
    def remote_action(id)
      get("/remote_actions/#{id}")['remote_action']
    end

    # Modify an existing Remote Action.
    #
    # @return [Hashie::Mash] Hash representing the remote action.
    # @param id [String, Integer] The id of the remote action
    # @param data [Hash] Remote Action attributes to update
    def update_remote_action(id, data)
      put("/remote_actions/#{id}", data)['remote_action']
    end

    # Create a new Log for a Remote Action.
    #
    # @return [Hashie::Mash] Hash representing the log
    # @param id [String, Integer] The id of the remote action
    # @param message [String] Log message
    def create_remote_action_log(id, message)
      data = { message: message }
      post("/remote_actions/#{id}/logs", data)['log']
    end
  end
end

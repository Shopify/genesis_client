module GenesisClient
  module Devices
    # Receive a list of all Devices.
    #
    # @return [Array<Hashie::Mash>] Array of hashes representing devices.
    # @example
    #   client = GenesisClient::Client.new
    #   client.devices
    def devices(type = nil)
      (type.nil? ? get('/devices') : get("/devices?type=#{type}"))['devices']
    end
    alias list_devices devices

    # Receive a single Device.
    #
    # @return [Hashie::Mash] Hash representing the device.
    # @param sku [String] The SKU of the device
    # @example
    #   client = GenesisClient::Client.new
    #   client.device('UNK-12345534')
    def device(sku)
      get("/devices/#{sku}")['device']
    end

    # Create a new Device.
    #
    # @return [Hashie::Mash] Hash representing the device
    # @param sku [Integer] The SKU of the new device
    def create_device(sku)
      post('/devices', sku: sku)['device']
    end

    # Modify an existing Device.
    #
    # @return [Hashie::Mash] Hash representing the device
    # @param sku [Integer] The SKU of the device
    # @param data [Hash] Device attributes to update
    def update_device(sku, data)
      put("/devices/#{sku}", data)['device']
    end

    # Create a new Log for a Device.
    #
    # @return [Hashie::Mash] Hash representing the log
    # @param sku [Integer] The SKU of the device
    # @param message [String] Log message
    def create_device_log(sku, message)
      data = { message: message }
      post("/devices/#{sku}/logs", data)['log']
    end

    # Create a new Log for the current Remote Action for a Device.
    #
    # @return [Hashie::Mash] Hash representing the log
    # @param sku [Integer] The SKU of the device
    # @param message [String] Log message
    def create_device_current_remote_action_log(sku, message)
      data = { current_action: 'true', log: { message: message } }
      post("/devices/#{sku}/logs", data)['log']
    end
  end
end

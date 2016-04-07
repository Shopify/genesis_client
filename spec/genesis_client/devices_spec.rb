require 'spec_helper'

describe GenesisClient::Devices do

  let(:client) { GenesisClient::Client.new(endpoint: 'https://genesis.example.com/', token: 'TEST') }

  describe '#devices' do
    it 'returns all devices' do
      stub_get('/api/devices').to_return(json_response('devices.json'))
      devices = client.devices
      expect(devices.first.hostname).to eq('app04.lax.example.com')
    end
  end

  describe '#device' do
    it 'returns a single device' do
      stub_get('/api/devices/UNK-12354621ad45').to_return(json_response('server.json'))
      device = client.device('UNK-12354621ad45')
      expect(device.hostname).to eq('app02.lax.example.com')
    end
  end

  describe '.update_device' do
    it 'updates an existing device' do
      data = {
        status: 'spare'
      }
      stub_put('/api/devices/UNK-12354621ad45', data).to_return(json_response('updated_device.json'))
      device = client.update_device('UNK-12354621ad45', data)
      expect(device.hostname).to eq('app02.lax.example.com')
      expect(device.status).to eq('spare')
    end
  end

end

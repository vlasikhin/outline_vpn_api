# frozen_string_literal: true

require "spec_helper"
require_relative "../../lib/outline_vpn_api/client"

describe OutlineVpnApi::Client do
  let(:api_url) { "https://api.outlinevpn.example.com" }
  let(:client) { described_class.new(api_url) }

  before do
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  describe "#keys_list" do
    let(:stubbed_response) do
      {
        "accessKeys" => [
          {
            "id" => "0",
            "name" => "main key",
            "password" => "Password",
            "port" => 10_000,
            "method" => "method",
            "accessUrl" => "ss://test@127.0.0.1:10000/?outline=1"
          }
        ]
      }
    end

    before do
      stub_request(:get, "#{api_url}/access-keys")
        .to_return(status: 200, body: stubbed_response.to_json)
    end

    it "fetches the list of keys" do
      expect(client.keys_list).to eq(stubbed_response["accessKeys"])
    end
  end

  describe "#transfered_data_by_id" do
    it "fetches the transferred data by id" do
      stubbed_response = { "bytesTransferredByUserId" => { "0" => 12_425_410_888 } }
      stub_request(:get, "#{api_url}/metrics/transfer")
        .to_return(status: 200, body: stubbed_response.to_json)

      expect(client.transferred_data_by_id).to eq(stubbed_response)
    end
  end

  describe "#create_key" do
    let(:stubbed_response) do
      {
        "id" => "9",
        "name" => "",
        "password" => "Password",
        "port" => 50_000,
        "method" => "method",
        "accessUrl" => "ss://test@127.0.0.1:50000/?outline=1"
      }
    end

    before do
      stub_request(:post, "#{api_url}/access-keys")
        .to_return(status: 200, body: stubbed_response.to_json)
    end

    it "creates a new key" do
      expect(client.create_key).to eq(stubbed_response)
    end
  end

  describe "#set_limit" do
    let(:key_id) { "1" }
    let(:limit) { 5000 }

    it "sets the limit for a key" do
      stub_request(:put, "#{api_url}/access-keys/#{key_id}/data-limit")
        .with(body: { limit: { bytes: limit } }.to_json)
        .to_return(status: 204)

      expect { client.set_limit(key_id, limit) }.to output("Limit for key_id: #{key_id} is #{limit} bytes\n").to_stdout
    end
  end

  describe "#rename_key" do
    let(:key_id) { "1" }
    let(:new_name) { "NewKeyName" }

    it "renames a key" do
      stub_request(:put, "#{api_url}/access-keys/#{key_id}/name")
        .with(body: { name: new_name }.to_json)
        .to_return(status: 204)

      expect { client.rename_key(key_id, new_name) }.to output("key_id: #{key_id}, renamed to #{new_name}\n").to_stdout
    end
  end

  describe "#delete_key" do
    let(:key_id) { "1" }

    it "deletes a key" do
      stub_request(:delete, "#{api_url}/access-keys/#{key_id}")
        .to_return(status: 204)

      expect { client.delete_key(key_id) }.to output("key_id: #{key_id}, deleted\n").to_stdout
    end
  end
end

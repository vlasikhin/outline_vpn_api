# frozen_string_literal: true

require "httparty"
require "json"

module OutlineVpnApi
  class Client
    include HTTParty
    headers "Content-Type" => "application/json"
    default_options.update(verify: false)

    def initialize(api_url)
      self.class.base_uri(api_url)
    end

    def keys_list
      get("/access-keys")["accessKeys"]
    end

    def transferred_data_by_id
      get("/metrics/transfer")
    end

    def create_key
      post("/access-keys")
    end

    def set_limit(key_id, limit)
      body = { limit: { bytes: limit } }.to_json
      put("/access-keys/#{key_id}/data-limit", body, "Limit for key_id: #{key_id} is #{limit} bytes")
    end

    def rename_key(key_id, name)
      body = { name: }.to_json
      put("/access-keys/#{key_id}/name", body, "key_id: #{key_id}, renamed to #{name}")
    end

    def delete_key(key_id)
      response = self.class.delete("/access-keys/#{key_id}")
      handle_response(response, "key_id: #{key_id}, deleted")
    end

    private

    def get(endpoint)
      parse_response(self.class.get(endpoint))
    end

    def post(endpoint, body = {})
      parse_response(self.class.post(endpoint, body:))
    end

    def put(endpoint, body, success_message)
      response = self.class.put(endpoint, body:)
      handle_response(response, success_message)
    end

    def parse_response(response)
      JSON.parse(response.body)
    end

    def handle_response(response, success_message)
      if response.code.to_i == 204
        puts(success_message)
        nil
      else
        parse_response(response)
      end
    end
  end
end

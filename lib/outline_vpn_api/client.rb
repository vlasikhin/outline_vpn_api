# frozen_string_literal: true

require "httparty"
require "json"

module OutlineVpnApi
  class Client
    include HTTParty
    base_uri ""
    default_options.update(verify: false)
    headers "Content-Type" => "application/json"

    def initialize(api_url)
      self.class.base_uri(api_url)
    end

    attr_reader :api_url

    def keys_list
      parse_response(self.class.get("/access-keys"))["accessKeys"]
    end

    def transfered_data_by_id
      parse_response(self.class.get("/metrics/transfer"))
    end

    def create_key
      parse_response(self.class.post("/access-keys"))
    end

    def set_limit(key_id, limit)
      response = self.class.put("/access-keys/#{key_id}/data-limit", body: { limit: { bytes: limit } }.to_json)
      handle_response(response, "Limit for key_id:#{key_id} is #{limit} bytes")
    end

    def rename_key(key_id, name)
      response = self.class.put("/access-keys/#{key_id}/name", body: { name: }.to_json)
      handle_response(response, "key_id:#{key_id}, renamed to #{name}")
    end

    def delete_key(key_id)
      response = self.class.delete("/access-keys/#{key_id}")
      handle_response(response, "key_id:#{key_id}, deleted")
    end

    private

    def parse_response(response)
      JSON.parse(response.body)
    end

    def handle_response(response, success_message)
      response.code.to_i == 204 ? puts(success_message) : parse_response(response)
    end
  end
end

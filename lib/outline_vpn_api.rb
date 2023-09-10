# frozen_string_literal: true

require "httparty"
require "json"

require_relative "outline_vpn_api/version"
require_relative "outline_vpn_api/client"

module OutlineVpnApi
  def self.new(api_url)
    OutlineVpnApi::Client.new(api_url)
  end
end

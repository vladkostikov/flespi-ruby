# frozen_string_literal: true

require "json"
require "net/http"
require "uri"

class Flespi
  attr_accessor :flespi_token, :debug

  VERSION = "1.0.2.1"

  def initialize(flespi_token, debug: false)
    self.flespi_token = flespi_token
    self.debug = debug
  end

  def get(url)
    uri = URI.parse("https://flespi.io#{url}")

    if debug
      puts "================ FLESPI REQUEST ================"
      puts "Request: GET https://flespi.io#{url}"
      puts "================================================"
    end

    request = Net::HTTP::Get.new(uri)

    validate_response(make_request(request, uri))
  end

  def create(url, parameters)
    uri = URI.parse("https://flespi.io#{url}")

    if debug
      puts "================ FLESPI REQUEST ================"
      puts "Request: POST https://flespi.io#{url}"
      puts "================================================"
    end

    request = Net::HTTP::Post.new(uri)

    validate_response(make_request(request, uri, parameters))
  end

  def update(url, parameters)
    uri = URI.parse("https://flespi.io#{url}")

    if debug
      puts "================ FLESPI REQUEST ================"
      puts "Request: PUT https://flespi.io#{url}"
      puts "================================================"
    end

    request = Net::HTTP::Put.new(uri)

    validate_response(make_request(request, uri, parameters))
  end

  def delete(url)
    uri = URI.parse("https://flespi.io#{url}")

    if debug
      puts "================ FLESPI REQUEST ================"
      puts "Request: DELETE https://flespi.io#{url}"
      puts "================================================"
    end

    request = Net::HTTP::Delete.new(uri)

    validate_response(make_request(request, uri))
  end

  protected

  def make_request(request, uri, parameters = nil)
    request["Accept"] = "application/json"
    request["Authorization"] = "FlespiToken #{flespi_token}"

    unless parameters.nil?
      if debug
        puts "================ FLESPI PARAMS ================"
        puts "Parameters: #{parameters.inspect}"
        puts "==============================================="
      end
      request.body = JSON.dump(parameters)
    end

    req_options = {
      use_ssl: uri.scheme == "https"
    }

    Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end

  def validate_response(response)
    case response.code.to_i
    when 200
      { error: false, message: JSON.parse(response.body) }
    when 400
      { error: true, message: "Invalid parameters", reason: JSON.parse(response.body) }
    when 401
      { error: true, message: "Invalid or missing flespi token" }
    when 403
      { error: true, message: "Flespi token blocked" }
    else
      { error: true, message: "Flespi internal server error" }
    end
  end
end

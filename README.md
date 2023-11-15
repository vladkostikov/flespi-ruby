# Flespi
[![Gem Version](https://badge.fury.io/rb/flespi-ruby.svg)](https://badge.fury.io/rb/flespi-ruby)

[Official documentation Flespi](https://flespi.io/docs/)

## Installation

Add this line to your application's Gemfile:

`gem "flespi-ruby"`

And then execute:

`bundle install`

## Usage

```ruby
require "flespi"

# Initialize flespi instance
flespi_client = Flespi.new("FlespiToken", debug: true)

# Get collection of all devices
flespi_client.get("/gw/devices/all")

# Get device by device id
flespi_client.get("/gw/devices/123456")

# Create new device
flespi_client.create("/gw/devices", ["configuration": { "ident": "123456" }, 
                                     "device_type_id": 10, 
                                     "name": "Device name"])

# Delete device by device id
flespi_client.delete("/gw/devices/123456")
```

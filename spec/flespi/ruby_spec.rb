# frozen_string_literal: true

RSpec.describe Flespi do
  token = "FlespiToken"
  it "create instance with token" do
    flespi = Flespi.new(token)
    expect(flespi.flespi_token).to be token
  end

  it "debugging mode is disabled by default" do
    flespi = Flespi.new(token)
    expect(flespi.debug).to be false
  end

  it "debugging mode can be enabled" do
    flespi = Flespi.new(token, debug: true)
    expect(flespi.debug).to be true
  end
end

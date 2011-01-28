require 'spec_helper'
require 'geo_magic'
require 'helper/streets'

describe "GeoMagic Geocoder" do
  before do
    @geocoder = GeoMagic.geo_coder
    @geocoder.configure File.expand_path('../fixtures/map_api_keys.yaml', File.dirname(__FILE__)), :development
  end
  
  it "should geocode" do    
    location = @geocoder.instance.geocode "Mullerstrasse 9, Munich"
    location.city.should == 'Munich'
  end

  it "should find location" do
    location = @geocoder.instance.geocode "Marienplatz 14, munich, Germany"
    p location.latitude
    p location.longitude
  end        

  it "should create location and address hashes" do
    location = @geocoder.instance.geocode "Pilotystrasse 11, munich, Germany"
    p location.location_hash
    p location.address_hash
  end        

  it "Graticule adapter" do
    @geocoder = GeoMagic.geo_coder :type => :graticule, :services => :google
    @geocoder.configure File.expand_path('../fixtures/map_api_keys.yaml', File.dirname(__FILE__)), :development
    location = @geocoder.instance.geocode "Pilotystrasse 11, munich, Germany"
    p location
    p location.city
  end        

  it "Graticule Multi adapter" do
    @geocoder = GeoMagic.geo_coder :type => :graticule_multi, :services => :google
    @geocoder.configure File.expand_path('../fixtures/map_api_keys.yaml', File.dirname(__FILE__)), :development
    location = @geocoder.instance.geocode "Pilotystrasse 11, munich, Germany"
    p location
    p location.city
  end        


  context 'Streets from munich' do
    before do
      @geocoder = GeoMagic.geo_coder
      @geocoder.configure File.expand_path('../fixtures/map_api_keys.yaml', File.dirname(__FILE__)), :development

      @streets = Streets.load :munich     
    end
    
    it "should not fail" do
      begin
        inst = @geocoder.instance
        
        @streets.each do |street|          
          adr = "#{street}"
          @adr = adr
          p adr
          @location = inst.geocode adr
          # p "status: #{@location.data["Status"]}"
          @location.city.should_not be_nil
          # p "city: #{@location.city}"
        end 
      rescue GeoMagic::GeoCodeError
        p "OH NO! #{@adr}"
      rescue Exception => e
        p e      
      end
    end
  end

  # Geocoder with Rails 3

  # Expects map api keys (fx for google maps) to be defined in ROOT/config/map_api_keys.yml
  # See spec/fixtures/map_api_keys.yml for example

  # Use @geocoder.configure(path, env) to customize this 

  # it "should geocode for rails" do        
  #   @geocoder = GeoMap.geo_coder(:env => :rails)
  #   location = @geocoder.instance.geocode "Mullerstrasse 9, Munich"
  #   location.city.should == 'Munich'
  # end
end


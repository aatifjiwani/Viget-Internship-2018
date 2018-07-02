class MapCoordinates
  def initialize(location)
    @location = location
  end

  def coordinates
    @coordinates ||= city_country.merge(formatted_lat_lon(response["candidates"][0]["geometry"]["location"]))
  end

  def api_url
    URI.encode("https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{@location}&inputtype=textquery&fields=formatted_address,geometry&key=#{Rails.application.credentials.dig(:gcs_map_api_key)}")
  end
  
  def response
    @response ||= JSON.parse(HTTP.get(api_url).as_json["body"][0])
  end
  
  def city_country
    @city_country ||= formatted_city_country(response["candidates"][0]["formatted_address"])
  end

  def formatted_city_country(location)
    split_location = location.gsub(" ", "").split(",")
    if split_location.length == 2
      formatted_location = {
        "country_name" => split_location[1],
        "city" => split_location[0]
        }
    elsif split_location.length == 3
      formatted_location = {
        "country_name" => split_location[2],
        "city" => split_location[1]
        }
    else
      len = split_location.length
      formatted_location = {
        "country_name" => split_location[len - 1],
        "city" => split_location[len - 3]
        }
    end
  end

  def formatted_lat_lon(coord_hash)
    formatted_latlon = {
      "latitude" => coord_hash["lat"],
      "longitude" => coord_hash["lng"]
      }
  end

end
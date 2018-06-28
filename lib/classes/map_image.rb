class MapImage
  def initialize(lat, lon, city)
    @lat = lat
    @lon = lon
    @city = city
  end
  
  def image
    "https://maps.googleapis.com/maps/api/staticmap?center=#{@lat},#{@lon}&zoom=10&size=200x200&markers=color:red%7C#{@city.gsub(" ", "+")}&key=#{Rails.application.credentials.dig(:gcs_map_api_key)}"
  end
end
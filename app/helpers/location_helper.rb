module LocationHelper
  def remote_ip
    if request.remote_ip == '127.0.0.1'
      '134.201.250.155'
    else
      request.remote_ip
    end
  end
  
  def get_only_location(json_object)
    json_object.slice("country_name", "city", "latitude", "longitude")
  end
  
  def location_api_url
    "http://api.ipstack.com/#{remote_ip}?access_key=#{Rails.application.credentials.dig(:geolocation_api_key)}"
  end
end
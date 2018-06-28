class Geolocater
  def initialize(remote_ip)
    if remote_ip == '127.0.0.1'
      @ip = '134.201.250.155'
    else
      @ip = remote_ip
    end
  end
  
  def location
    api_request = JSON.parse(HTTP.get(api_url).as_json["body"][0])
    response = api_request.slice("country_name", "city", "latitude", "longitude")
  end
  
  def api_url
    "http://api.ipstack.com/#{@ip}?access_key=#{Rails.application.credentials.dig(:geolocation_api_key)}"
  end
  
end
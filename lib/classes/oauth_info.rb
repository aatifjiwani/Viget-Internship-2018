class OauthInfo
  def getinfo(provider, response)
    if provider == "facebook"
      user_params = {
        username: create_username(response["name"]),
        email: response["email"]
        }
    elsif provider == 'linkedin'
      user_params = {
        username: create_username(info["name"]),
        email: info["email"],
        location: MapCoordinates.new(info["location"]).coordinates
        }
    end
  end

  def getimg(response)
    if response["image"]
      image = grab_image(response["image"])
    end
  end

  def create_username(full_name)
    user = full_name.split(" ")
    case user.length
    when 1
      full_name.downcase
    when 2
      full_name.gsub(" ", "").downcase
    else
      "#{user.first}#{user.last}".downcase
    end
  end

  def grab_image(url)
    downloaded_image = open(url)
  end
end
class V1::AboutController < ApplicationController


  def setting

    setting_array = Hash.new

    setting_array['privacy_url'] = $new_app_url.to_s+'setting/privacy'

    setting_array['version_url'] = $new_app_url.to_s+'setting/version'

    setting_array['about_url'] = $new_app_url.to_s+'setting/about'

    setting_array['review_app_url'] = $new_app_url.to_s+'setting/review_app'

    echoJson(setting_array)

  end

end
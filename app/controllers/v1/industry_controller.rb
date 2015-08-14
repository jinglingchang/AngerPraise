class V1::IndustryController < ApplicationController


  def getIndustryMain

    industry_module = IndustryModule.new

    industry_module.getMainIndustry

    response.headers['Content-Type'] = 'application/json'
    render :json => array

  end

end
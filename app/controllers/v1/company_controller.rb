class V1::CompanyController < ApplicationController


  def detail

    company_id = params['company_id']

    company_module = CompanyModule.new

    if company_id.to_i > 0

      company_module.getCompanyInfoById(company_id)

    else

      company_module.setErrorCode(101)

    end


    echoJson(company_module)


  end

  #根据公司ID获取职位列表

  def get_position_list

    company_id = params['company_id']

    company_module = CompanyModule.new

    if company_id != nil

      company_module.getPositionInfoByCompanyId(company_id)

    else

      company_module.echoErrorCode 101

    end

    echoJson(company_module)

  end


  def collect

    company_id = params[:company_id]

    user_id = params[:user_id]

    company_module = CompanyModule.new

    if user_id.to_i > 0 and company_id.to_i > 0

      company_module.companyCollectByUserIdAndCompanyId(user_id,company_id)

    else

      company_module.setErrorCode(101)

    end

    response.headers['Content-Type'] = 'application/json'

    echoJson(company_module)

  end

end
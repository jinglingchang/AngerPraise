class V1::ResumeController < ApplicationController

  def collect

    user_id = params[:user_id]

    html = params[:html]

    #html = File.read("/web/www/test/index.html")

    resume_module = ResumeModule.new

    user_module = UserModule.new

    if user_id.to_i > 0 and html != nil

      #记录用户ID以及DOM元素存放到数据库中。

      user_module.checkUserResume(user_id)

      if user_module.error != nil

        result = user_module

      else

        resume_module.resume_collect(html,user_id)

        result = resume_module

      end

    else

      resume_module.setErrorCode(101)

      result = resume_module

    end



    render :json => result

  end


  def create

    user_id = params[:user_id]

    user_name = params[:user_name]

    user_sex = params[:user_sex]

    user_age = params[:user_age]

    user_education_id = params[:education_id]

    user_position = params[:position]

    user_company = params[:company_name]

    user_compensation_id =  params[:user_compensation]

    resume_module = ResumeModule.new

    if user_id != nil  and user_name != nil  and user_sex != nil  and user_age != nil  and user_education_id.to_i != nil  and  user_position != nil and user_company != nil and user_compensation_id != nil

      create_hash = Hash.new

      create_hash['user_id'] = user_id

      create_hash['name'] = user_name

      create_hash['dict_sex_id'] = user_sex

      create_hash['dict_age_id'] = user_age

      create_hash['user_position'] = user_position

      create_hash['user_company'] = user_company

      create_hash['dict_education_id'] = user_education_id

      create_hash['dict_salary_id'] = user_compensation_id

      resume_module.create_resume(create_hash)

    else

      resume_module.setErrorCode(101)


    end



    render :json=>resume_module

  end

end
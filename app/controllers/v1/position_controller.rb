class V1::PositionController < ApplicationController

  def recommended_position

    type = params[:type]

    user_id = params[:user_id]

    position_module = PositionModule.new

    if  type != nil and user_id != nil

      position_module.positionSearch(type.to_i,user_id)

    else

      position_module.setErrorCode(101)

    end


    echoJson(position_module)

  end


  def senior_search

    user_id = params['user_id']

    keyword = params['keyword']

    work_place_id = params['work_place_id']

    work_year_id = params['work_year_id']

    compensation_id = params['compensation_id']

    position_module = PositionModule.new

    if keyword == nil  and work_place_id = 0 and work_year_id = 0 and compensation_id > 0

      position_module.positionSearch(1,user_id)

    else

      position_module.seniorSearch(user_id,keyword,work_place_id,work_year_id,compensation_id)

    end

    #response.headers['Content-Type'] = 'application/json;charset=utf-8'

    echoJson(position_module)


  end

  def apply

    user_id = params[:user_id]

    position_id = params[:position_id]

    position_module = PositionModule.new

    if user_id.to_i > 0 and position_id.to_i > 0

      position_module.applyPosition(user_id, position_id)

    else

      position_module.setErrorCode(101)

    end

    #response.headers['Content-Type'] = 'application/json;charset=utf-8'

    echoJson(position_module)

  end

  def apply_list

    company_id = params[:company_id]

    position_module = PositionModule.new

    position_module.getPositionApply(company_id)

    #response.headers['Content-Type'] = 'application/json;charset=utf-8'

    render :json => position_module.to_json

  end

  def detail

    position_id = params['position_id']

    if position_id != nil

      position_module = PositionModule.new

      position_module.getPositionDetail(position_id)

    else

      position_module.echoErrcode(101)

    end

    echoJson(position_module)

  end

  #获取所有的职位申请记录

  def apply_all_record

    if params[:page] != nil

      page = params[:page]

    else

      page = 1

    end

    position_module = PositionModule.new

    position_module.getPositionAll(page,params[:orderby])

    #response.headers['Content-Type'] = 'application/json charset=utf-8'

    echoJson(position_module)

  end

end
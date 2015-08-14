module Search

  attr_accessor :position_id

  attr_accessor :position_name

  attr_accessor :company_name

  attr_accessor :work_place

  attr_accessor :education

  attr_accessor :match_number

  attr_accessor :rank

  attr_accessor :competition_number

  attr_accessor :subsidies_interview

  attr_accessor :position

  attr_accessor :type

  attr_accessor :create_time

  attr_accessor :web_url

  attr_accessor :interview_url

  attr_accessor :interview_status

  attr_accessor :recommended_number

  attr_accessor :hot_job_status

  attr_accessor :now_hiring_status

  attr_accessor :high_salary_status

  attr_accessor :subsidies_interview_status

  attr_accessor :company_map_status

  attr_accessor :company_video_status

  attr_accessor :hot_word

  def positionSearch(type, user_id)

    if  type != nil and user_id != nil

      arrays = Array.new

      #获取用户简历中的关键字 进行职位查询

      user_resume = Resumes.where('user_id ='+user_id.to_s).take

      if user_resume != nil

        user_position_name = user_resume['user_position']

        if user_position_name != nil

          current_month_unix_time = Time.now.year.to_s+'-'+(Time.now.month - 3).to_s+'-1'

          result = PositionsAll.where('name like "%'+user_position_name.to_s+'%" and company_update_time > "'+current_month_unix_time+'"').order('company_update_time DESC').limit(20)

          arrays = self.searchPostionPorcoess(result, 1, user_id)

          if arrays.length.to_i <= 0

            result = PositionsAll.where('name like "%php%" and company_update_time > "'+current_month_unix_time+'"').order('company_update_time DESC').limit(20)

            arrays = self.searchPostionPorcoess(result, 1, user_id)

          end

          self.position =arrays

          self.recommended_number = arrays.length

        else

          self.setErrorCode(40004)

        end


      else

        self.setErrorCode(40004)

      end


    end


  end

  def searchPostionPorcoess(result, type, user_id)

    if result != nil

      array = Array.new

      result.each do |v|

        position_module = self.set_position_value(v, type, user_id)

        array << position_module

      end

      array

    end


  end


  def set_position_value(v,type,user_id)

    company_info = Company.where('id = '+v['company_id'].to_s).select('company_name').take

    if company_info != nil

      company_name = company_info['company_name']

    else

      company_name = '暂无'

    end

    position_module = PositionModule.new

    position_module.position_id = v['id'].to_s

    position_module.company_name = company_name.blank? ? '暂无' : company_name

    position_module.position_name = v['name'].blank? ? '暂无' : v['name']

    position_module.work_place = v['working_place'].blank? ? '暂无' : v['working_place']

    position_module.education = v['formal_schooling'].blank? ? '暂无' : v['formal_schooling']

    position_module.match_number = self.positioncompatibility.to_s

    position_module.rank = self.competitiveness_rank.to_s

    position_module.competition_number = self.competition_number.to_s

    position_module.type = type.to_s

    position_module.create_time = DateTime.parse(v['company_update_time'].to_s).strftime('%m-%d')

    position_module.web_url = $new_app_url.to_s+'position/info?position_id='+v['id'].to_s+'&user_id='+user_id.to_s

    position_module.subsidies_interview_status = v['subsidies_interview'].to_s

    position_module.hot_job_status = rand(0..1).to_i

    position_module.now_hiring_status = rand(0..1).to_i

    position_module.high_salary_status = rand(0..1).to_i

    position_module.company_map_status = rand(0..1).to_i

    position_module.company_video_status = rand(0..1).to_i

    position_module.hot_word = Array['有管理能力', '3年以上经验', 'BAT背景']

    position_module

  end


  def position_info(id)

    position_info = Positions.where('id = '+id.to_s).take

    if position_info != nil

      position_id = position_info['id']

      position_name = position_info['name'].gsub(' ', '')

      position_update_time = position_info['company_update_time']

      company_id = position_info['company_id']

      position_result_detail = PositionsDetails.where('positions_id = '+position_info['id'].to_s).select('positions_id,working_place,formal_schooling').take

      working_place = position_result_detail['working_place']

      formal_schooling = position_result_detail['formal_schooling']

      company_info = Company.where('id = '+company_id.to_s).select('company_name').take

      company_name = company_info['company_name']

      self.position_id = position_id.to_s

      self.company_name = company_name.blank? ? '暂无' : company_name

      self.position_name = position_name.blank? ? '暂无' : position_name.gsub(' ', '')

      self.work_place = working_place.blank? ? '暂无' : working_place

      self.education = formal_schooling.blank? ? '暂无' : formal_schooling

      self.match_number = self.positioncompatibility.to_s

      self.rank = self.competitiveness_rank.to_s

      self.competition_number = self.competition_number.to_s

      self.subsidies_interview = position_info['subsidies_interview'].to_s

      self.create_time = DateTime.parse(position_update_time).strftime('%m-%d')


    end

  end

# 职位匹配度
  def positioncompatibility()

    rand(1..50)

  end

  def seniorSearch(user_id, keyword, work_place_id, work_year_id, compensation_id)

    sql_search = '1'

    if keyword != nil

      sql_search+= ' AND name like "%'+keyword.to_s+'"'

    end

    if work_place_id != nil

      sql_search+= ' AND dict_work_places_id = '+work_place_id.to_s+''

    end

    if work_year_id != nil

      sql_search+= ' AND dict_hirelib_workexperice_id = '+work_year_id.to_s+''

    end

    if compensation_id != nil

      sql_search+= ' AND dict_hirelib_salary_id = '+compensation_id.to_s+''

    end

    result = Positions.where(sql_search).limit(20)

    arrays = searchPostionPorcoess(result,1,user_id)

    self.position =arrays

    self.recommended_number = arrays.length

  end

end
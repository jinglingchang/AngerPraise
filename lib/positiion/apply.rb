module Apply

  attr_accessor :user_id

  attr_accessor :company_name

  attr_accessor :apply_time

  attr_accessor :apply_list

  attr_accessor :currentPage

  attr_accessor :fina_page

  attr_accessor :apply_position_status

  attr_accessor :apply_id

  def applyPosition(user_id, position_id)

    if user_id.to_i > 0 and position_id.to_i > 0

      user_module = UserModule.new

      user_module.userInfo(user_id)

      if user_module.user_id.to_i > 0

        position_module = PositionModule.new

        position_module.getPositionInfoByID(position_id)

        if position_module.position_id.to_i > 0

          arrayHash = Hash.new

          arrayHash['user_id'] = user_id

          arrayHash['position_id'] = position_id

          arrayHash['apply_time'] = Time.now.to_i

          arrayHash['dict_status_id'] = 4

          PositionApply.create(arrayHash)

          self.res = 1.to_s

        end

      else

        self.setErrorCode(user_module.error['code'])

      end

    end

  end

  #获取职位申请记录

  def getPositionApply(company_id)

    if company_id != nil

      position_apply_array = Array.new

      company_info = Companies.where('id = '+company_id.to_s).take

      position_id_array = Positions.where('company_id = '+company_id.to_s).select('id', 'name')

      position_id_array.each do |v|

        if v['id'] != nil

          #查询APP中的职位申请表 查询是否有该职位的申请记录

          apply = PositionApply.where('position_id = '+v['id'].to_s)

          position_apply_array_temp = Array.new

          if apply != nil

            apply.each do |apply_v|

              #获取用户的质量度

              user_dal = User.new

              user_quality_number = user_dal.getUserQuality(apply_v['user_id'])

              #

              position_apply_hash = Hash.new

              position_apply_hash['user_id'] = apply_v['user_id']

              position_apply_hash['user_quality_number'] = user_quality_number

              position_apply_hash['position_name'] =v['name']

              position_apply_hash['company_name'] = company_info['company_name']

              position_apply_hash['apply_time'] = Time.at(apply_v['current_times']).strftime('%Y-%m-%d %H:%M:%S')

              position_apply_array_temp << position_apply_hash

            end

            position_apply_array_sort = position_apply_array_temp.sort { |x, y| x['user_quality_number'] <=> y['user_quality_number'] }

            position_apply_array +=position_apply_array_sort.reverse

            position_apply_array_temp

          end

        end

      end

      self.apply_list = position_apply_array

    end


  end

  #获取所有的职位申请记录，显示职位名称，公司名称，第二部分显示用户姓名，学历，
  def getPositionAll(page, orderby)

    if page != nil

      offsetNumber = (page.to_i - 1) * 10.to_i

    else

      offsetNumber =0

    end

    position_apply_all = PositionApply.limit(10).offset(offsetNumber)

    position_array = Array.new

    if position_apply_all != nil

      position_apply_all.each do |v|

        #获取职位名称以及公司名称

        if v['position_id'] != nil

          position_result = Positions.where('id = '+v['position_id'].to_s).select('id,company_id,name').take

          if position_result != nil

            position_hash = Hash.new

            #获取公司名称

            company_info = Companies.where('id = '+position_result['company_id'].to_s).select('company_name').take

            if company_info != nil

              position_hash['position_name'] = position_result['name'].to_s.gsub(' ', '')

              position_hash['company_name'] = company_info['company_name']

            end

            #获取用户简历中的信息，姓名，年龄，工作经验，学历，质量度，匹配度

            hirelib_resume = AppHirelibResume.where('user_id = '+v['user_id'].to_s).select('user_name,app_resume_id,user_age,hirelib_workexperice_id').take

            if hirelib_resume != nil

              position_hash['user_name'] = hirelib_resume['user_name']

              position_hash['user_age'] = hirelib_resume['user_age']

              #获取工作经验

              hirelib_workexperience = HirelibWorkExperience.where('hirelib_work_experience_id = '+hirelib_resume['hirelib_workexperice_id'].to_s).select('hirelib_work_experience_name').take

              position_hash['work_experience'] = hirelib_workexperience['hirelib_work_experience_name']

              #获取质量度以及匹配度

              resume_module = ResumeModule.new

              position_hash['match'] = resume_module.resume_match

              position_hash['quality'] = resume_module.resume_quality

            end


            position_hash['apply_time'] = Time.at(v['current_times']).strftime('%Y-%m-%d %H:%M:%S')

            position_array << position_hash

          end

        end

      end

      if orderby == 'quality'

        a = position_array.sort { |x, y| x['quality'] <=> y['quality'] }

      elsif orderby == 'match'

        a = position_array.sort { |x, y| x['match'] <=> y['match'] }
      else

        a = position_array.sort { |x, y| x['apply_time'] <=> y['apply_time'] }

      end


      self.apply_list = a.reverse

      self.currentPage = page.to_i

      position_number = PositionApply.all.count

      if position_number.to_i > 0

        all_page = (position_number / 10.0).round

      end

      self.fina_page = all_page

    end


  end


end
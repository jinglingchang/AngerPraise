module Resume

  attr_accessor :user_resume_perfect

  attr_accessor :user_resume_competitiveness

  attr_accessor :user_resume_synthesize_grade

  attr_accessor :user_position

  attr_accessor :user_dynamic_number

  attr_accessor :resume_perfect_url

  attr_accessor :resume_preview_url

  attr_accessor :synthesize_grade

  attr_accessor :synthesize_grade_url

  attr_accessor :resume_url

  attr_accessor :resume_update_time

  attr_accessor :resume_status

  attr_accessor :resume_match_number

  attr_accessor :live

  attr_accessor :create_resume_url

  attr_accessor :objective_functions

  attr_accessor :compensation_name

  def createResumeUrl(user_id)

    if user_id != nil

      self.create_resume_url = $new_app_url +'resume/create_resume?user_id='+user_id.to_s

    end

  end


  def getUserResumeUrl(user_id)

    if user_id != nil

      self.synthesize_grade_url = $new_app_url+'user/user_synthesize_grade?user_id='+user_id.to_s

      user_info = User.where('id = '+user_id.to_s).take

      if user_info != nil

        self.synthesize_grade =user_info['user_resume_source'].to_f.ceil.to_s

      end
      
    end

  end

  def getUserResumePerfectUrl(user_id)

    if user_id != nil

      self.resume_perfect_url = $new_app_url+'resume/resume_perfect?user_id='+user_id.to_s

    end

  end


  def checkUserResume(user_id)

    if user_id.to_i > 0

      user_dal = User.new

      user_info = user_dal.userInfo(user_id)

      if user_info != nil

        app_resume = Resumes.where('user_id = '+user_id.to_s).take

        if app_resume != nil

          self.setErrorCode(40001)

        end

      else

        self.setErrorCode(10004)

      end

    end

  end

  #通过用户ID检查简历状态

  def checkResumeByUserId(user_id)

    if user_id != nil

      user_info = User.where('id = '+user_id.to_s).take

      if user_info != nil

        #判断用户是否存在简历

        hirelib_resume = Resumes.where('user_id = ' + user_id.to_s+' and current_step = 5').take

        if hirelib_resume != nil

          self.resume_status = 1

        else

          self.resume_status = 0

        end

      end

    end

  end

  def getInfoResumeByUserId(user_id)

    if user_id != nil

      user_dal = User.new

      user_info = user_dal.userInfo(user_id)

      if user_info != nil

        hirelib_resume = Resumes.where('user_id = ' + user_id.to_s+' and current_step = 5').take

        self.checkResumeByUserId(user_id)

        if hirelib_resume != nil

          self.user_position = hirelib_resume['user_position']

          self.user_resume_synthesize_grade = self.getUserResumeSynthesizeGrade(user_id)

          self.resume_update_time = Time.at(hirelib_resume['resume_update_time']).strftime('%Y-%m-%d')

          self.objective_functions = hirelib_resume['objective_functions']

          if hirelib_resume['dict_salary_id'].to_i > 0

            result = DictHirelibCompensation.where('hirelib_compensation_id = '+hirelib_resume['dict_hirelib_compensation_id']).take

            if result != nil

              self.compensation_name = result['hirelib_compensation_name']

            else

              self.compensation_name = '暂无'

            end

          else

            self.compensation_name = '暂无'
          end

          self.resume_match_number = rand(1..40)


        end

      else

        self.setErrorCode(10004)

      end

    end

  end

  def getUserResumeCompetitiveness()

    return rand(1..60)

  end

  def getUserResumePerfect()

    return rand(1..60)

  end

  def getUserResumeSynthesizeGrade(user_id)

    if user_id != nil

      user_info = User.where('id = '+user_id.to_s).take

      if user_info['user_resume_source'].to_i.ceil().to_i > 80

        return 80.to_s

      else

        return user_info['user_resume_source'].to_i.ceil().to_s

      end

    end

  end

  def perfectUserResume(user_id, userPerfectHash)

    if userPerfectHash.length.to_i > 0 and user_id != nil

      user_dal = User.new

      user_info = user_dal.userInfo(user_id)

      if user_info != nil

        hirelib_resume = Resumes.where('user_id = '+user_id.to_s).take

        userPerfectHash['user_id'] = user_id

        hirelib_resume.update(userPerfectHash)

        self.res = '1'

      else

        self.setErrorCode(10004)

      end


    end

  end

  #获取推荐职位数量 根据简历是否创建

  def getPositionNumberByResume(user_id)

    if user_id != nil

      user_resume = Resumes.where('user_id = '+user_id.to_s).take

      if user_resume != nil

        self.position_number = 20.to_s

      else

        self.position_number = 0.to_s

      end

    end

  end


  def getResumePerviewUrl(user_id)

    if user_id != nil

      self.resume_preview_url = $new_app_url.to_s+'user/user_resume/?user_id='+user_id.to_s

    end

  end

end
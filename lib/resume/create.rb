module Create


  def create_resume(resumeHash)

    if resumeHash.length.to_i > 0

      #验证用户是否存在

      if resumeHash['user_id'].to_i > 0

        user_module = UserModule.new

        user_module.userInfo(resumeHash['user_id'])

        if  user_module.error != nil

          self.setErrorCode(user_module.error['code'])

        else

          #检查学历ID 是否在HIRELIB教育表中存在

          if resumeHash['hirelib_education_id'].to_i > 0 and resumeHash['hirelib_compensation_id'].to_i > 0

            education = HirelibEducation.where('hirelib_education_id = '+resumeHash['hirelib_education_id'].to_s).take

            if education == nil

              self.setErrorCode(40002)

            else

              compensation = HirelibCompensation.where('hirelib_compensation_id = '+resumeHash['hirelib_compensation_id'].to_s).take

              if compensation == nil

                self.setErrorCode(40003)

              else

                app_hirelib_resume = AppHirelibResume.create(resumeHash)

                if app_hirelib_resume.id.to_i > 0

                  self.res = 1.to_s

                end

              end

            end

          end

        end


      end


    end

  end

end
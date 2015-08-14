module Interview


  attr_accessor :interview_number

  attr_accessor :hr_interview_number

  attr_accessor :interview_url

  attr_accessor :interview_list


  def hr_status(user_id)

    if user_id != nil

      user_info = User.where('id = '+user_id.to_s).take

      if user_info != nil

        if user_info['hr_privilege'].to_i == 1

          self.getUserInterviewCount(user_id)

        end

      end

    end

  end


  def getInterview(user_id)

    if user_id != nil

      user_info = User.where('id = '+user_id.to_s).take

      if user_info != nil

        self.countUserFriend(user_id)


        self.getUserInterviewCount(user_id)

        #判断用户是否为HR

        if user_info['hr_privilege'].to_i == 1

          self.getHRInterviewCount(user_id)

        end

      end


    end

  end


  #获取用户可以申请的面试补贴的个数

  # 1.从职位申请记录表中，查询这个用户的所有的职位申请记录

  # 2.遍历结果。用职位ID 来查询职位库 判断该职位是否有面试补贴

  # 3.如当前职位是存在面试补贴的时候 查询用户面试补贴记录库，查询用户是否已经领取过面试补贴

  # 4.如已经领取过面试补贴，不计算再内

  def getUserInterviewCount(hr_user_id)

    number = 0

    if hr_user_id != nil

      array = Array.new

      user_info = User.where('id = '+hr_user_id.to_s).take

      if user_info != nil

        employers_user_id = user_info['employers_account_id']

        employers_account = EmployersAccount.where('id = '+employers_user_id.to_s).take

        if employers_account != nil

          #获取该雇主所填写的公司ID

          employers_company_id = employers_account['employers_company_id']

          employers_position_info = Positions.where('employers_company_id = '+employers_company_id.to_s+' and subsidies_interview = 1')

          if employers_position_info != nil

            employers_position_info.each do |v|

              user_position_apply = PositionApply.where('position_id = '+v['id'].to_s)

              if user_position_apply != nil

                user_position_apply.each do |apply_v|

                  #查询用户是否已经提出面试补贴申请

                  user_interview_evaluation = InterviewEvaluation.where('types = 0 and  user_id = '+apply_v['user_id'].to_s + ' and user_apply_id = '+apply_v['id'].to_s).take

                  if user_interview_evaluation != nil


                    if user_interview_evaluation['status'].to_i == 0

                      number+=1

                    end

                  end

                end

              end


            end

          end


        end


      end


    end

    self.hr_interview_number = number.to_i

  end


  #获取HR对应聘者的点评

  # 1.从用户库中获取该HR的雇主平台ID

  # 2.从雇主平台库中获取该雇主平台的公司ID

  # 3.从职位库中查询该雇主平台的公司ID 查询结果

  # 4.遍历查询出来的结果，在职位申请表中 进行搜索

  # 5.使用用户ID HR用户ID 以及 职位ID 在普通用户对公司的面试评价表中进行查询，如存在。说明已经申请了。无需该数据

  def getHRInterviewCount(hr_user_id)

    number = 0

    if hr_user_id != nil

      user_info = User.where('id = '+hr_user_id.to_s).take

      if user_info != nil

        employers_user_id = user_info['employers_user_id']

        employers_account = EmployersAccount.where('id = '+employers_user_id.to_s).take

        if employers_account != nil

          #获取该雇主所填写的公司ID

          employers_info = EmployersUser.where('id = '+employers_account['employers_user_id'].to_s).take

          employers_company_id = employers_info['employers_company_id']

          employers_position_info = Positions.where('employers_company_id = '+employers_company_id.to_s+' and subsidies_interview = 1')

          if employers_position_info != nil

            employers_position_info.each do |v|

              user_position_apply = PositionApply.where('position_id = '+v['id'].to_s)

              if user_position_apply != nil

                user_position_apply.each do |apply_v|

                  #查询用户是否已经提出面试补贴申请

                  user_interview_evaluation = InterviewEvaluation.where('status = 0 and user_id = '+apply_v['user_id'].to_s + ' and position_id = '+v['id'].to_s).take

                  if user_interview_evaluation != nil

                    number+=1

                  end

                end

              end


            end

          end


        end


      end


      self.hr_interview_number = number.to_s

    end

  end


  #获取HR对应聘者的点评

  # 1.从用户库中获取该HR的雇主平台ID

  # 2.从雇主平台库中获取该雇主平台的公司ID

  # 3.从职位库中查询该雇主平台的公司ID 查询结果

  # 4.遍历查询出来的结果，在职位申请表中 进行搜索

  # 5.使用用户ID HR用户ID 以及 职位ID 在普通用户对公司的面试评价表中进行查询，如存在。说明已经申请了。无需该数据

  def getHRInterviewList(hr_user_id)

    number = 0

    hr_all = 0

    hr_award = 0

    if hr_user_id != nil

      array = Array.new

      user_info = User.where('id = '+hr_user_id.to_s).take

      if user_info != nil

        employers_user_id = user_info['employers_account_id']

        employers_account = EmployersAccount.where('id = '+employers_user_id.to_s).take

        if employers_account != nil

          #获取该雇主所填写的公司ID

          employers_company_id = employers_account['employers_company_id']

          employers_position_info = Positions.where('employers_company_id = '+employers_company_id.to_s+' and subsidies_interview = 1')

          if employers_position_info != nil

            employers_position_info.each do |v|

              user_position_apply = PositionApply.where('position_id = '+v['id'].to_s)

              if user_position_apply != nil

                user_position_apply.each do |apply_v|

                  #查询用户是否已经提出面试补贴申请

                  user_interview_evaluation = InterviewEvaluation.where('types = 0 and  user_id = '+apply_v['user_id'].to_s + ' and user_apply_id = '+apply_v['id'].to_s).take

                  if user_interview_evaluation != nil

                    #判断HR是否已经评价过该用户

                    user_module = UserModule.new

                    user_module.userInfo(apply_v['user_id'])

                    user_module.friend_evluation_url = $new_app_url.to_s + 'hr/review_time?hr_user_id='+hr_user_id.to_s+'&id='+user_interview_evaluation['id'].to_s

                    array << user_module

                    if user_interview_evaluation['status'] == 1

                      hr_award+=1

                    end

                    hr_all+=1

                  end

                end

              end


            end

          end


        end

        if hr_all.to_i > 0

          self.today_award_total = hr_all.to_i * 20

        else

          self.today_award_total = 0

        end


        if hr_award.to_i > 0

          self.today_receive_award = hr_award * 20

        else

          self.today_receive_award = 0

        end

        self.interview_list = array


      end


    end

  end


end
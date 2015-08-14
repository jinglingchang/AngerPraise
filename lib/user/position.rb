module Position


  attr_accessor :positions_collect

  attr_accessor :apply_position_list

  attr_accessor :interview_status

  def getUserCollect(user_id)

    userCollect = UserCollect.where('user_id = '+user_id.to_s+' and collect_type = 0')

    if userCollect != nil

      result = Array.new

      if userCollect.length.to_i > 0

        userCollect.each do |v|

          if v['position_id'].to_i > 0

            position_module = PositionModule.new

            position_module.position_info(v['position_id'])

            if position_module != nil

              result << position_module

            end

          end

        end

      end

      self.positions_collect = result

    end

  end


  def getUserPositionApply(user_id)

    if user_id != nil

      position_apply = PositionApply.where('user_id = '+user_id.to_s)

      array = Array.new

      array_intview = Array.new

      if position_apply != nil

        if position_apply.length.to_i > 0

          position_apply.each do |v|

            #查询该职位是否存在面试补贴

            position_module = PositionModule.new

            position_module.position_info(v['position_id'])

            position_module.web_url = $app_url.to_s+'position/detail?position_id='+v['position_id'].to_s+'&user_id='+user_id.to_s

            number = position_module.subsidies_interview.to_i

            dict_position_apply = DictPositionApplyStatus.where('id ='+v['dict_status_id'].to_s).take

            if dict_position_apply != nil

              position_module.apply_position_status = dict_position_apply['status_name'].to_s

            end

            position_module.apply_id =v['id']

            if number == 1

              #如该公司是存在面试补贴的，查询普通用户对公司的评价表，查询该用户是否已经领取过面试补贴

              user_interview = InterviewEvaluation.where('user_id = '+user_id.to_s+' and user_apply_id = '+v['id'].to_s+' and types = 0').take

              if user_interview == nil

                position_module.interview_status = '-1'

                position_module.interview_url = $interview_url.to_s + '&apply_id='+v['id'].to_s

              else

                position_module.interview_status = user_interview['status'].to_s

              end

              array_intview << position_module

            else

              array << position_module

            end


          end

        end

      end

     self.apply_position_list = array_intview + array

    end

  end

end
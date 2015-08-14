module Friend

  attr_accessor :review_friend_list

  attr_accessor :friend_evluation_url

  attr_accessor :friend_evluation_status

  attr_accessor :friend_number

  attr_accessor :today_award_total

  attr_accessor :today_receive_award


  def getTodayEvationArray(user_id, array, key)

    if user_id != nil and array != nil

      new_task_array = Hash.new

      #获取好友列表 进行好友补充

      user_invitaion = UserEvaluation.where('user_id = '+user_id.to_s).take

      if user_invitaion != nil

        invitaion_string = user_invitaion['evaluation_friend_string']

        if invitaion_string != nil

          invitaion_string_length = invitaion_string.length

          string = invitaion_string[1, invitaion_string_length.to_i - 2]

          string_array = string.split('|')

          user_array = Array.new

          #判断用户是否存在

          string_array.each do |v|

            user_module = UserModule.new

            user_module.userInfo(v)

            if user_module.user_id.to_i > 0

              user_array << v

            end

          end

          p user_array

          all_number = 5 - array.length.to_i

          current_number = 0

          if user_array.length.to_i > 0

            while current_number < all_number do

              current_number+=1

              current_length = key.to_i + 1

              fid = user_array[key].to_s

              result = array.include? fid

              if  result == false

                array << fid

              end

              if current_length >= user_array.length.to_i

                key = 0

              else

                key+=1

              end

            end


          end

        end


      else

        add = Hash.new

        add['user_id'] = user_id

        UserEvaluation.create(add)

      end

      new_task_array['array'] = array

      new_task_array['key'] = key

      new_task_array

    end

  end


  def today_award(user_id)

    if user_id != nil

      self.getUserTaskMoney(user_id)

    end

  end


  #用户评价，遍历好友列表，判断是否为黑名单中的好友并且可评价好友数小于5个，则获取用户信息

  def userReview(user_id, friend_array)

    friend_number = 0

    if user_id != nil and friend_array != nil

      today_task_friend_array = Array.new

      #判断用户是否第一次登录应用

      user_info = User.where('id = '+user_id.to_s).take

      if user_info != nil

        if user_info['user_mission'].to_i == 0

          friend_array.unshift(0.to_s)

          #修改状态  不出现小怒

          # update_status = Hash.new
          #
          # update_status['frist_login'] = 1
          #
          # user_info.update(update_status)

        end

        if friend_array.length.to_i <= 0

          friend_array.unshift(0.to_s)


        end

      end

      if friend_array.length.to_i > 0

        friend_list_array = Array.new

        #循环好友列表 获取评论好友的时间，如超过2周，那么可以评论，否则不显示在列表

        friend_array.each do |v|

          user_module = UserModule.new

          #判断用户是否存在

          user_module.userInfo(v)

          if user_module.user_id.to_i > 0

            fid_string = v.to_s

            #判断该黑名单数组中 是否存在该好友

            strings_array = self.getUserBackListByUserId(user_id)

            if strings_array != nil

              result = strings_array.include? fid_string

            else

              result = false

            end


            if v != nil and result == false and friend_number.to_i<5

              #获取我评论该好友的时间

              user_evaluation = UserEvaluationDetail.where('evaluation_user_id = '+user_id.to_s + ' and by_evaluation_user_id = '+v.to_s).order('evaluation_time DESC').take

              if user_evaluation != nil

                two_week_time = user_evaluation['evaluation_time'].to_i + 86400

                #获取当前凌晨时间

                evaluation_time = Time.at(user_evaluation['evaluation_time'].to_i)

                evaluation_year = evaluation_time.strftime('%Y')

                evaluation_month = evaluation_time.strftime('%m')

                evaluation_day = evaluation_time.strftime('%d')

                evaluation_mktime = Time.mktime(evaluation_year, evaluation_month, evaluation_day).to_i

                current_time = Time.mktime(Time.now.year, Time.now.month, Time.now.day).to_i

                userInfo = User.where('id = '+v.to_s).take

                if userInfo != nil

                  if current_time > evaluation_mktime

                    user_module.userInfo(v)


                    user_module.friend_evluation_status = 1

                    user_module.friend_evluation_url = $new_app_url.to_s + 'user/review/?user_id='+user_id.to_s+'&fid='+v.to_s

                    today_task_friend_array << v.to_s

                    friend_list_array << user_module

                    friend_number+=1

                  else

                    user_module.userInfo(v)

                    user_module.friend_evluation_status = 0

                    user_module.friend_evluation_url = $new_app_url.to_s + 'user/review/?user_id='+user_id.to_s+'&fid='+v.to_s

                    today_task_friend_array << v.to_s

                    friend_list_array << user_module

                    friend_number+=1

                  end

                end

              else

                userInfo = User.where('id = '+v.to_s).take

                if userInfo != nil

                  user_module.userInfo(v)

                  user_module.friend_evluation_status = 1

                  user_module.friend_evluation_url = $new_app_url.to_s + 'user/review/?user_id='+user_id.to_s+'&fid='+v.to_s

                  friend_list_array << user_module

                  today_task_friend_array << v.to_s

                  friend_number+=1

                end

              end

            end

            self.review_friend_list = friend_list_array

          else

            if v.to_i == 0

              user_info = User.where('id = '+user_id.to_s).take

              if user_info != nil

                #如果一个好友都不存在 将系统的默认好友添加到该列表

                user_module.user_name = '小怒'

                user_module.photo_url = $photo_url.to_s + 'photo/defaults.jpg'

                user_module.friend_evluation_url = $new_app_url.to_s + 'user/mission/?user_id='+user_id.to_s

                friend_list_array << user_module

                today_task_friend_array << v.to_s

                # update = Hash.new

                # update['user_mission'] = 1

                # user_info.update(update)


              end

            end

            self.review_friend_list = friend_list_array

          end

        end

      else


        self.review_friend_list = Array.new

      end

    end

    today_task_friend_array

  end


  #添加好友到数据库

  def addUserFriend(user_id, fid)

    if user_id != nil and fid != nil

      user_invitaion = UserEvaluation.where('user_id = '+user_id.to_s).take

      if user_invitaion != nil

        invitaion_string = user_invitaion['evaluation_friend_string']

        if invitaion_string != nil

          invitaion_string_length = invitaion_string.length

          string = invitaion_string[1, invitaion_string_length.to_i - 2]

          string_array = string.split('|')

        else

          string_array = Array.new

        end


        fid_string = fid.to_s

        #判断该数组中 是否存在该好友

        result = string_array.include? fid_string

        if result != true

          string_array << fid

          new_friend_string = '|'+string_array.join('|').to_s+'|'

          update = Hash.new

          update['evaluation_friend_string']=new_friend_string

          user_invitaion.update(update)

        end


      end

    end

  end


  def addUserBackList(user_id, fid)

    if user_id != nil and fid != nil

      #获取用户的好友列表，判断fid是否在好友字符串中存在,如存在，添加到黑名单列中

      user_invitaion = UserEvaluation.where('user_id = '+user_id.to_s).take

      if user_invitaion != nil

        invitaion_string = user_invitaion['user_blacklist_list']

        if invitaion_string != nil

          backlist_strings = invitaion_string[1, invitaion_string.to_i - 2]

          backlist_string_array = backlist_strings.split('|')

        else

          backlist_string_array = Array.new

        end

        fid_string = fid.to_s

        #判断该数组中 是否存在该好友

        result = backlist_string_array.include? fid_string

        if result != true

          backlist_string_array << fid

          new_friend_string = '|'+backlist_string_array.join('|').to_s+'|'

          update = Hash.new

          update['user_blacklist_list']=new_friend_string

          user_invitaion.update(update)

        end

      end

      self.res = 1.to_s

    end

  end

end
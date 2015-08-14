module Task



  def updateAndAddTodayTask(user_id, array)

    if user_id != nil and array != nil

      today_time = Time.mktime(Time.now.year, Time.now.month, Time.now.day).to_i

      user_task = UserTask.where('user_id = '+user_id.to_s+' and insert_time like "'+today_time.to_s+'"').take

      task_array = array['array']

      key = array['key']

      if task_array.length.to_i > 0

        new_string = '|'+task_array.join('|').to_s+'|'

      end

      if user_task != nil

        if task_array.length.to_i > 0

          update = Hash.new

          update['review_friend_string'] = new_string

          update['current_key'] = key

          user_task.update(update)

        end

      else

        addTodayTaskHash = Hash.new

        addTodayTaskHash['user_id'] = user_id

        addTodayTaskHash['review_friend_string'] =new_string

        addTodayTaskHash['current_key'] = key

        addTodayTaskHash['insert_time'] = today_time

        UserTask.create(addTodayTaskHash)

      end

    end

  end

  def getTodayTaskListArray(user_id)

    if user_id != nil

      #判断今日是否已插入任务,如已插入任务,判断个数是否足够,不足够,进行好友补充

      today_time = Time.mktime(Time.now.year, Time.now.month, Time.now.day).to_i

      user_task = UserTask.where('user_id = '+user_id.to_s+' and insert_time like "'+today_time.to_s+'"').take

      if user_task != nil

        current_key = user_task['current_key']

        user_task_string = user_task['review_friend_string']

        if user_task_string != nil

          task_string_length = user_task_string.length

          string = user_task_string[1, task_string_length.to_i - 2]

          string_array = string.split('|')

          string_array_length = string_array.length.to_i

          if string_array_length < 5

            result = self.getTodayEvationArray(user_id, string_array, current_key)

          else

            result = Hash.new

            result['array'] = string_array

            result['key'] = current_key

          end

        else

          string_array = Array.new

          current_key = 0

          result = self.getTodayEvationArray(user_id, string_array, current_key)

        end

      else

        #获取最新的用户任务数记录 如存在数据,获取最新的任务数据以及key值

        user_task = UserTask.where('user_id = '+user_id.to_s).order('insert_time DESC').take

        if user_task != nil

          current_key = user_task['current_key']

          string_array = Array.new

          result = self.getTodayEvationArray(user_id, string_array, current_key)

        else

          string_array = Array.new

          current_key = 0

          result = self.getTodayEvationArray(user_id, string_array, current_key)

        end

      end

      self.updateAndAddTodayTask(user_id, result)

      self.userReview(user_id, result['array'])

    end

  end



  def getUserTaskMoney(user_id)

    if user_id != nil

      today_time = Time.mktime(Time.now.year, Time.now.month, Time.now.day).to_i

      user_task = UserTask.where('user_id = '+user_id.to_s+' and insert_time like "'+today_time.to_s+'"').take

      today_award_total_string = 0

      today_receive_award_string = 0

      if user_task != nil

        review_friend_array = self.formatStringToArray(user_task['review_friend_string'])

        if review_friend_array != nil and review_friend_array.length.to_i > 0

          have_friend_array = self.formatStringToArray(user_task['have_review_friend_string'])

          have_friend_update = 0

          review_friend_array.each do |v|

            if v.to_i > 0

              fid = v.to_s

              #查询数据库中的评价记录表,判断今日用户是否对该好友进行过评价,并在已评价好友数组中进行

              user_review_record = UserEvaluationDetail.where('evaluation_user_id = '+user_id.to_s+' and by_evaluation_user_id = '+fid+' and evaluation_time >= '+today_time.to_s).take

              if user_review_record != nil

                result = have_friend_array.include? fid

                if result != true

                  have_friend_array << fid

                  have_friend_update = 1

                end

                today_receive_award_string+=5

              end

              today_award_total_string+=5

            end

          end

        end

      end

      if have_friend_update.to_i == 1

         have_friend_string = self.formatArrayToString(have_friend_array)

        if have_friend_string != nil

          updateHaveFriend = Hash.new

          updateHaveFriend['have_review_friend_string'] = have_friend_string

          user_task.update(updateHaveFriend)

        end

      end

      self.today_receive_award = today_receive_award_string

      self.today_award_total = today_award_total_string

    end

  end

end
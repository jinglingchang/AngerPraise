module BackList

  def getUserBackListByUserId(user_id)

    if user_id != nil

      user_invitaion = UserEvaluation.where('user_id = '+user_id.to_s).take

      if user_invitaion != nil

        #----------黑名单---------------------

        backlist_string = user_invitaion['user_blacklist_list']

        if backlist_string != nil

          backlist_string_length = backlist_string.length

          backlist_strings = backlist_string[1, backlist_string_length.to_i - 2]

          strings_array = backlist_strings.split('|')

        else

          strings_array = Array.new

        end

      end


    end

  end

end
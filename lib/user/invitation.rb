module Invitation


  def deal_phone(user_id, phone_book)

    if phone_book != nil and user_id != nil

      phone_book_array = Array.new

      #获取当前用户的设备

      user_device = UserDevice.where('user_id = '+user_id.to_s).take

      if user_device != nil

        device = user_device['device']

        case device

          when 'ios' then

            letter_array = 'abcdefghijklmnopqrstuvwxyz'

            for i in 0..25

              letter = letter_array[i]

              if phone_book[letter] != nil

                lengths = phone_book[letter].length

                aa = phone_book[letter]

                if lengths.to_i > 0

                  aa.each do |v|

                    if v['first'].to_s.empty? and v['last'].to_s.empty? and v['telphone'].to_s.empty?

                    else

                      phone_book_hash = Hash.new

                      name = v['last'].to_s+v['first'].to_s

                      phone = v['telphone'].to_s.gsub('-', '').gsub(' ','')

                      phone_book_hash['name'] = name

                      phone_book_hash['phone'] = phone

                      phone_book_array << phone_book_hash

                    end
                  end

                end

              end

            end

        end

      end

      if phone_book_array.length.to_i > 0

        self.invitation_phone_book(user_id, phone_book_array)

        self.res = 1.to_s

      end

    end


  end

  #邀请手机通讯录

  def invitation_phone_book(user_id, phone_book_hash)

    invitation_array = Array.new

    if user_id != nil and phone_book_hash != nil

      if  phone_book_hash.length.to_i > 0

        phone_book_hash.each do |v|

          #判断该手机是否在邀请库中存在，如不存在。则添加未激活账号以及好友绑定

          phone = v['phone'].to_s

          user_name = v['name'].to_s

          base64_encode_phone = Base64.strict_encode64(phone)

          source = Base64.decode64(base64_encode_phone)

          #查询该手机号码是否已邀请

          user_invitation = UserInvitation.where('user_id = '+user_id.to_s+' and invitation_string like "%|'+base64_encode_phone.to_s+'|%"').take

          if user_invitation == nil

            #查询该手机号码的用户是否已在我们APP应用中，注册过

            user_info = User.where('user_phone like "'+phone+'" and user_status = 1').take

            if user_info == nil

              #插入未激活账号

              info = self.addUserInactiveAccount(phone, user_name)

              #将未激活的账号的用户ID与该用户ID进行好友绑定

              if info != nil

                self.createCodeByUserId(info.id)

                self.default_photo(info.id)

                self.addUserFriend(user_id, info.id)

                #发送邀请短信

                message_module = MessageModule.new

                message_module.sendMessageInviation(phone)

              end

            else

              self.addUserFriend(user_id, user_info.id)

            end

            invitation_array << base64_encode_phone

          end

        end

      end

      if invitation_array.length.to_i > 0

        addInvitation = Hash.new

        addInvitation['user_id'] = user_id

        addInvitation['invitation_string'] = '|'+invitation_array.join('|').to_s+'|'

        UserInvitation.create(addInvitation)

      end


    end

  end

end
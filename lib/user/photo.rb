module Photo

  #默认头像，读取默认图片将新注册的用户以用户ID为图片名称保存在服务器中

  def default_photo(user_id)

    if user_id != nil

      user_info = User.where('id = '+user_id.to_s).take

      if user_info != nil

        update = Hash.new

        update['photo_name'] = 'photo.png'

        user_info.update(update)

      end

    end

  end

  def updateUserPhoto(user_id, file)

    if user_id.to_i > 0

      self.updateUserPhotoStatus(user_id)

      self.uploadFile(file, user_id)

    end

  end

  def uploadFile(file, user_id)

    if !file.original_filename.empty?

      photo_name = Time.now.to_i.to_s + '.jpg'

      File.open("/data/web/ruby/photo/#{photo_name}", "wb") do |f|
        f.write(file.read)
      end

      user_info = User.where('id = '+user_id.to_s).take

      if user_info != nil

        update = Hash.new

        update['photo_name'] = photo_name

        user_info.update(update)

      end

      self.photo_url = self.getUserPhoto(user_id)

    end
  end

  def updateUserPhotoStatus(user_id)

    if user_id != nil

      user_info = User.where('id = '+user_id.to_s).take

      #判断用户的来源 是否为微信第三方平台

      if user_info != nil


        if user_info['dict_source_id'].to_i == 1

          #获取微信第三方信息库

          user_weixin_info = WeixinBinding.where('user_id = '+user_id.to_s).take

          if user_weixin_info != nil

            if user_weixin_info['weixin_photo_status'].to_i == 0

              update = Hash.new

              update['weixin_photo_status'] = 1

              user_weixin_info.update(update)

            end

          end

        end

      end


    end

  end

  def getUserPhoto(user_id)

    if user_id != nil

      user_info = User.where('id = '+user_id.to_s).take

      photo_url = ''

      #判断用户的来源 是否为微信第三方平台

      if user_info['dict_source_id'].to_i == 1 and user_info['photo_name'] == 'photo.png'

        #获取微信第三方信息库

        user_weixin_info = WeixinBinding.where('user_id = '+user_id.to_s).take

        if user_weixin_info != nil

          photo_url = user_weixin_info['weixin_headimgurl']

        end

      else

        if user_info['photo_name'] == nil

          photo_name = 'photo.png'

        else

          photo_name = user_info['photo_name']

        end

        photo_url = $photo_url.to_s + 'photo/'+photo_name.to_s

      end

      photo_url

    end

  end

end
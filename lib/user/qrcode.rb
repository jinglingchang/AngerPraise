module QRcode


  attr_accessor :code_url

  def createCodeByUserId(user_id)

    userDal = User.new

    if user_id.to_i > 0


      userInfo = User.where('id = '+user_id.to_s).take


      if userInfo['id'] > 0

        qr = RQRCode::QRCode.new("hirelib_"+self.user_id.to_s)

        png=qr.to_img

        png.resize(90, 90).save("/data/web/ruby/qr/hirelib_"+self.user_id.to_s+".png")

      end

    end

  end

  def getUserCodeUrl(user_id)

    if user_id != nil

      user_info = User.where('id = '+user_id).take

      if user_info != nil

        self.code_url = $photo_url.to_s + 'qr/hirelib_'+user_id.to_s+'.png'

      end

    end

  end


end
module Tokens

  attr_accessor :token

  def createToken(user_id)

    if user_id != nil

      #生成用户TOKEN

      p '--------------------------------'

      Token.where('user_id = '+user_id.to_s).delete_all

      token_name = Digest::MD5.hexdigest('hirelib_'+Time.now.to_i.to_s+rand(1..100).to_s)

      createToken = Hash.new

      createToken['user_id'] = user_id

      createToken['token_name'] = token_name

      createToken['token_create_time'] = Time.now

      Token.create(createToken)

      self.token = token_name

    end


  end


end
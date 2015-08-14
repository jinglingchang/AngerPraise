class TokenController < ApplicationController


  def index

    user_module = UserModule.new

    user_module.addUserFriend(1,3)

  end
end

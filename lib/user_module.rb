
require 'father_module'

require 'user/login'

require 'user/register'

require 'user/info'

require 'user/qrcode'

require 'user/photo'

require 'user/position'

require 'user/resume'

require 'user/initial_passwords'

require 'user/friend'

require 'user/dynamic'

require 'user/interview'

require 'user/invitation'

require 'user/device'

require 'user/task'

require 'user/backlist'

require 'user/password'

require 'user/token'

class UserModule < FatherModule

  include Login

  include Register

  include Info

  include QRcode

  include Position

  include Photo

  include Resume

  include InitialPasswords

  include Friend

  include Interview

  include Invitation

  include Dynamic

  include Device

  include Task

  include BackList

  include Password

  include Tokens

end

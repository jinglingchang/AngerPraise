require 'error/error_list'

class FatherModule

  $app_url = 'http://app.hirelib.com/AngerPraiseWebs/'

  $photo_url = 'http://app.hirelib.com/'

  $new_app_url = 'http://app.hirelib.com/website/'

  $interview_url = 'http://app.hirelib.com/AngerPraiseWebs/user/subsidies_interview/?type=0'

  $hr_interview_url = 'http://app.hirelib.com/AngerPraiseWebs/user/hr_subsidies_interview/?type=1'

  attr_accessor :code

  attr_accessor :info

  attr_accessor :res

  attr_accessor :error

  def echoErrorCode(code)

    errorHash = Hash.new

    if $error_List[code].to_s != ''

      errorHash['code'] = code

      errorHash['info'] = $error_List[code]

      self.error = errorHash

    end

  end

  def setErrorCode(code)

    if code != nil and code.to_i > 0

      $error_code = code

    end

  end


  def formatStringToArray(string)

    string_array = Array.new

    if string != nil

      string_length = string.length

      string = string[1, string_length.to_i - 2]

      string_array = string.split('|')

    end

    string_array

  end

  def formatArrayToString(array)

    if array != nil  and array.length.to_i > 0

      new_friend_string = '|'+array.join('|').to_s+'|'

      new_friend_string

    end

  end

  def fitlerHtmlCode(string)

    if string != nil

      string.gsub(/<\/?.*?>/,"")

      string

    end

  end

  def filterString(string,fitler)

    if string != nil  and fitler != nil

      string.gsub(fitler,'')

      string

    end

  end

  def filterCompanyString(string)

    string = self.fitlerHtmlCode(string)

    string = self.filterString(string,'&#160;')

    p string

  end


end
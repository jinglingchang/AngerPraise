module Info


  attr_accessor :company_id

  attr_accessor :company_name

  attr_accessor :company_address

  attr_accessor :company_code

  attr_accessor :company_info

  attr_accessor :company_website

  attr_accessor :company_url

  attr_accessor :company_industry

  attr_accessor :company_nature

  attr_accessor :company_scale

  def getCompanyNameAndCompanyIdById(id)

    if id != nil

      company_info = Company.where('id = '+id.to_s).take

      if company_info != nil

        if company_info['id'] != nil

          self.company_id = company_info['id']

        end

        if company_info['company_name'] != nil

          self.company_name = company_info['company_name']

        end

      else

        self.setErrorCode(30000)

      end

    end

  end

  def getCompanyInfoById(id)

    if id != nil

      company_info = Company.where('id = '+id.to_s).take

      if company_info != nil

        if company_info['id'] != nil

          self.company_id = company_info['id']

        end

        if company_info['company_name'] != nil

          self.company_name = company_info['company_name']

        end


        if company_info['company_code'] != nil

          self.company_code = company_info['company_code']

        end

        if company_info['company_info'] != nil

          self.company_info = company_info['company_info']

        end

        if company_info['company_website'] != nil

          self.company_website = company_info['company_website']

        end

        if company_info['company_address'] != nil

          self.company_address = company_info['company_address']

        end

        if company_info['company_url'] != nil

          self.company_url = company_info['company_url']

        end

        if company_info['company_industry'] != nil

          self.company_industry = filterCompanyString(company_info['company_industry'])

        end


        if company_info['company_nature'] != nil

          self.company_nature = company_info['company_nature']

        end

        if company_info['company_industry'] != nil

          self.company_scale = company_info['company_scale']

        end

      else

        self.setErrorCode(30000)

      end

    end

  end

end
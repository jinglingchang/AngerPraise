module Info


  attr_accessor :position_name

  attr_accessor :release_date

  attr_accessor :working_place

  attr_accessor :hiring

  attr_accessor :position_id

  attr_accessor :company_id

  attr_accessor :salary_range

  attr_accessor :formal_schooling

  attr_accessor :work_year

  attr_accessor :job_description

  attr_accessor :job_functions

  attr_accessor :company_info

  attr_accessor :position_info

  attr_accessor :position_list


  def getPositionInfoByID(id)

    if id != nil

      position_info = PositionsAll.where('id = '+id.to_s).take

      if position_info != nil

        self.position_id = position_info['id']

        self.company_id = position_info['company_id']

        self.position_name = position_info['name']

        self.release_date = position_info['release_date']

        self.working_place = position_info['working_place'].split('-')[0]

        self.hiring = position_info['hiring']

        self.salary_range = position_info['salary_range']

        self.formal_schooling = position_info['formal_schooling']

        self.work_year = position_info['work_year']

        self.job_description = position_info['job_description']

        self.job_functions = position_info['job_functions']

      else

        self.setErrorCode(20000)

      end

    end

  end

  def getPositionDetail(id)

    if id.to_i > 0

      position_module = PositionModule.new

      position_module.getPositionInfoByID(id)

      if position_module.position_id.to_i > 0

        company_module = CompanyModule.new

        company_module.getCompanyNameAndCompanyIdById(position_module.company_id)

        if company_module.company_id.to_i > 0

          self.company_info = company_module

        end

        self.position_info = position_module

      end


    end

  end

  def getPositionInfoByCompanyId(company_id)

    if company_id != nil

      position_result = PositionsAll.where('company_id ='+company_id.to_s).limit(3)

      result = Hash.new

      if position_result != nil

        position_result.each do |v|

          position_module = PositionModule.new

          position_module.getPositionInfoByID(v['id'])

          if position_module.position_id.to_i > 0

            result << position_module

          end

        end

      end

      result

    end

  end


end
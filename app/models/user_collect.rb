
class UserCollect < ActiveRecord::Base




  self.table_name = 'user_collect'


  def createUserCompanyCollect(user_id,company_id)

    if user_id.to_i > 0 and company_id.to_i > 0

      arrayHash = Hash.new

      arrayHash['user_id'] = user_id

      arrayHash['company_id'] = company_id

      arrayHash['company_collect_time'] = Time.now.to_i

      arrayHash['collect_type'] = 2

      userCollectObject = UserCollect.create(arrayHash)

    end

  end

end

module Collect


  def positionCollectByUserIdAndPositionId(user_id,position_id)

    if user_id.to_i > 0 and position_id.to_i > 0

      arrayHash = Hash.new

      arrayHash['user_id'] = user_id

      arrayHash['position_id'] = position_id

      arrayHash['position_collect_time'] = Time.now.to_i

      arrayHash['collect_type'] = 0

      UserCollect.create(arrayHash)


    end

  end

end
module Device

  def saveUserDevice(user_id,dict_device_id,device_id,device_name,device_version)

    #修改用户的设备信息

    user_deliver = UserDevice.where('user_id = '+user_id.to_s+' and dict_device_id = '+dict_device_id.to_s+' and device_version like  "'+device_version.to_s+'" and device_name like "'+device_name.to_s+'"').take

    if user_deliver == nil

      addDeviceHash = Hash.new

      addDeviceHash['dict_device_id'] = dict_device_id

      addDeviceHash['device_id'] = device_id

      if device_id != '0'

        addDeviceHash['device_status'] = 1

      end

      addDeviceHash['user_id'] = user_id

      addDeviceHash['device_name'] = device_name

      addDeviceHash['device_version'] = device_version

      UserDevice.create(addDeviceHash)

    end

    self.res = 1
  end

end
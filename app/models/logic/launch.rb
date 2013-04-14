# encoding: utf-8
module Logic
  class Launch

    def self.init params
      error_res = {
          statusCode: 0,
          errorMessage: '非法操作！'
      }

      return error_res unless params['userID']

      device = Device.find_or_create_by_uid(params['userID'])
      return error_res if device.nil?

      {
          statusCode: 1,
          response: {}
      }
    end

  end
end

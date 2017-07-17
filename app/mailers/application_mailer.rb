require 'google/apis/gmail_v1'

Gmail = Google::Apis::GmailV1

class MailService

  def initialize(params)
    @params = params
  end

  def call
    message = Gmail::Message.new
    service = Gmail::GmailService.new
    message.raw = (redacted)
    service.request_options.authorization = current_user.token.fresh_token
    result = service.send_user_message(current_user.email, message)
  end

end
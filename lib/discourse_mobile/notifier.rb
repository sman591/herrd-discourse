module Herrd
  class Notifier
    API_SERVER = "https://herrd-push-server.csh-cloud.oweb.co/api/"

    def deliver notification
      return if notification.read?

      notification_text = notification.text_description + notification.topic.title

      @data = {
        api_key: SiteSetting.mobile_api_key,
        contents: {
          en: notification_text
        },
        user_id: notification.user_id
      }
      @action = "send"

      send_request
    end

    def send_request
      uri = URI.parse("#{API_SERVER}#{@action}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      headers = {
        "Content-Type"  => "application/json"
      }

      request = Net::HTTP::Post.new(uri.path, headers)
      request.body = JSON.generate(@data)

      process_result http.request(request)
    end

    def process_result result
      raise DeliveryException unless result.body == "Success"
    end
  end
end

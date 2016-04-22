module Jobs
  class HerrdNotifier < Jobs::Base
    def execute(args)
      notification = Notification.find(args[:notification_id])
      return if not notification

      Herrd::Notifier.new.deliver notification
    end
  end
end

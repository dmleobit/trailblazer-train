module ApplicationHelper
  ALERTS = {
    notice:     'alert-success',
    success:    'alert-success',
    error:      'alert-error',
    auth_error: 'alert-error',
    alert:      'alert-danger',
    info:       'alert-info'
  }.freeze

  def alerts_from_flash(payload, type: :notice)
    case payload
    when String then flash_message(payload, type: type)
    when Array
      content_tag(:div) { payload.each { |msg| concat flash_message(msg, type: type) } }
    else raise "Payload not supported: must be in [String, Array]. #{payload.class} is given."
    end
  end

  def flash_message(message, type: :notice)
    content = <<-HTML
      <div class="alert alert-block #{ALERTS[type]}">
        <button type="button" class="close" data-dismiss="alert">
          <i class="icon-remove"></i>
        </button>
        #{'<i class="icon-ok green"></i>' if %i[success notice].include?(type)}
        #{message}
      </div>
    HTML
    content.html_safe
  end
end

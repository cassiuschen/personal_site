class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  if Rails.env.production?
    # some bots using some *strange* format to request urls
    # that would trigger missing template exception,
    # so this will reject those request, but you can adjust to your logic
    rescue_from ActionView::MissingTemplate do
      head :not_acceptable
    end

    # rails 4 will raise this exception when action can not respond request format
    rescue_from ActionController::UnknownFormat do
      head :not_acceptable
    end

    rescue_from ArgumentError do
      head :bad_request
    end

    rescue_from EncodingError do
      head :bad_request
    end

    rescue_from ActionController::InvalidCrossOriginRequest do
      head :bad_request
    end

    rescue_from ActionController::ParameterMissing do
      head :bad_request
    end
  end
end

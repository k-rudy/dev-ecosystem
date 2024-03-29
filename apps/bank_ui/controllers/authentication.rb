# frozen_string_literal: true

module BankUI
  module Controllers
    module Authentication
      def self.included(action)
        action.class_eval do
          expose :current_user
        end
      end

      def current_user
        @current_user ||= warden.user
      end

      def warden
        request.env['warden']
      end

      def authenticate_user!
        redirect_to '/auth/:provider/callback' unless current_user
      end
    end
  end
end

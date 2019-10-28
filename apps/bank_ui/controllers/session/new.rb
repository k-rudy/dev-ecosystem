# frozen_string_literal: true

module BankUI
  module Controllers
    module Session
      class New
        include BankUI::Action

        def auth_hash
          request.env['omniauth.auth']
        end

        def call(_params)
          user = UserRepository.auth!(auth_hash)
          warden.set_user user
          redirect_to '/'
        end

        def warden
          request.env['warden']
        end
      end
    end
  end
end

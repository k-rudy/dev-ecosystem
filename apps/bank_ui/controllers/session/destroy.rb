# frozen_string_literal: true

module BankUI
  module Controllers
    module Session
      class Destroy
        include BankUI::Action

        def call(_params)
          warden.logout
          redirect_to '/'
        end
      end
    end
  end
end

# frozen_string_literal: true

module BankUI
  module Controllers
    module Session
      class Failure
        include BankUI::Action

        def call(_params)
          status 404, 'Not found'
        end
      end
    end
  end
end

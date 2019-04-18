module Bank
  module Interactors
    module Integrations
      module BpsSberbank
        class CreateOperationFromNode
          include Hanami::Interactor

          expose :operation

          def initialize(node:, user_id:)
            @node = node
            @user_id = user_id
          end

          def call
            # binding.pry
          end
        end
      end
    end
  end
end

module Bank
  module Interactors
    module Operations
      class Create
        include Hanami::Interactor

        expose :operation

        def initialize(data:, user_id:, operation_repository: OperationRepository.new,
                       account_repository: AccountRepository.new)
          @data = data
          @user_id = user_id
          @operation_repository = operation_repository
          @account_repository = account_repository
        end

        def call
          account = @account_repository.find_or_create(params: account_params)
          @operation_repository.create(@data[:operation].merge(account_id: account.id))
        end

        private

        def account_params
          @data[:account].merge(user_id: @user_id)
        end
      end
    end
  end
end

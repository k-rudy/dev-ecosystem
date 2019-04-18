module Bank
  module Interactors
    class ImportOperations
      include Hanami::Interactor

      def initialize(file:, user_id:,
                     nodes_interactor: Integrations::BpsSberbank::ExtractOperationNodes.new(file: file))
        @user_id = user_id
        @nodes_interactor = nodes_interactor
        @operations = []
      end

      def call
        operation_nodes.each do |node|
          result = create_operation_interactor(node: node).call
          @operations << result.operation if result.successful?
        end
      end

      private

      def operation_nodes
        @nodes_interactor.call.nodes
      end

      def create_operation_interactor(node:)
        Integrations::BpsSberbank::CreateOperationFromNode.new(node: node, user_id: @user_id)
      end
    end
  end
end

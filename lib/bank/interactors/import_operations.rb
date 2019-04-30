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
          result = extract_operation_data_interactor(node: node).call
        end
      end

      private

      def operation_nodes
        result = @nodes_interactor.call
        error(result.errors) if result.failure?
        result.nodes
      end

      def extract_operation_data_interactor(node:)
        Integrations::BpsSberbank::ExtractOperationDataFromNode.new(node: node, user_id: @user_id)
      end
    end
  end
end

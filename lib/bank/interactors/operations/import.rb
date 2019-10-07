# frozen_string_literal: true

module Bank
  module Interactors
    module Operations
      class Import
        include Hanami::Interactor

        expose :operations

        def initialize(file:, user_id:,
                       nodes_interactor: Integrations::BpsSberbank::ExtractOperationNodes.new(file: file))
          @user_id = user_id
          @nodes_interactor = nodes_interactor
          @operations = []
        end

        def call
          operation_nodes.each do |node|
            data_list = extract_operation_data(node: node)
            data_list.each do |data|
              # log_data(data)
              create_operation(data: data) if @errors.nil?
            end
          end
        end

        private

        def operation_nodes
          result = @nodes_interactor.call
          error(result.errors) if result.failure?
          result.nodes
        end

        def extract_operation_data(node:)
          result = extract_operation_data_interactor(node: node).call
          error(result.errors) if result.failure?
          result.data
        end

        def extract_operation_data_interactor(node:)
          Integrations::BpsSberbank::ExtractOperationDataFromNode.new(node: node, user_id: @user_id)
        end

        def create_operation(data:)
          result = create_operation_interactor(data: data).call
          if result.failure?
            error(result.errors)
          else
            @operations << result.operation
          end
        end

        def create_operation_interactor(data:)
          Operations::Create.new(data: data, user_id: @user_id)
        end

        # rubocop:disable AbcSize
        def log_data(data)
          return if data[:operation][:type] == 'debit'

          puts([data[:operation][:date],
                data[:operation][:document_number],
                data[:operation][:value],
                data[:operation][:value_equivalent],
                data[:operation][:currency_rate],
                data[:operation][:details][:detpay],
                data[:operation][:counteragent][:name]].join(', '))
        end
        # rubocop:enable AbcSize
      end
    end
  end
end

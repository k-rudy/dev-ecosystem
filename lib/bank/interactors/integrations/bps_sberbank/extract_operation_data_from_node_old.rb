# frozen_string_literal: true

module Bank
  module Interactors
    module Integrations
      module BpsSberbank
        class ExtractOperationDataFromNodeOld
          include Hanami::Interactor

          expose :data

          def initialize(node:, user_id:)
            @node = node
            @user_id = user_id
          end

          def call
            @data = operations.map do |operation|
              {
                account: account_data,
                operation: operation_data(operation)
              }
            end
          end

          private

          def operations
            @node.css('operinfo oper')
          end

          def account_data
            {
              number: @node.css('accountinfo account').text,
              currency_iso: @node.css('accountinfo currency').attribute('iso').value,
              currency_code: @node.css('accountinfo currency').attribute('code').value,
              name: @node.css('accountinfo name').text
            }
          end

          # rubocop:disable AbcSize, MethodLength
          def operation_data(operation)
            {
              date: @node.css('accountinfo timeturn').attribute('date').value,
              time: @node.css('accountinfo timeturn').attribute('time').value,
              counteragent: counteragent_data(operation),
              document_number: operation.css('docn').text,
              currency_iso: @node.css('accountinfo currency').attribute('iso').value,
              currency_code: @node.css('accountinfo currency').attribute('code').value,
              currency_rate: @node.css('accountinfo currency').attribute('rate').value.to_f,
              value: operation_value(operation),
              value_equivalent: equivalent_value(operation),
              type: type(operation),
              details: details(operation),
              name: name(operation)
            }
          end
          # rubocop:enable AbcSize, MethodLength

          def counteragent_data(operation)
            {
              bank_code: operation.css('mfokorr').text,
              bank_account: operation.css('acckorr').text,
              name: operation.css('namekorr').text,
              unp: operation.css('unpkorr').text
            }
          end

          def operation_value(operation)
            attribute = debit?(operation) ? 'nd' : 'nk'
            operation.css('sumoper').attribute(attribute).value
          end

          def debit?(operation)
            operation.css('sumoper').attribute('nk').value.empty?
          end

          def equivalent_value(operation)
            attribute = debit?(operation) ? 'ed' : 'ek'
            operation.css('sumoper').attribute(attribute).value
          end

          def details(operation)
            {
              detpay: operation.css('detpay').text
            }
          end

          def type(operation)
            debit?(operation) ? 'debit' : 'credit'
          end

          def name(operation)
            type(operation)
          end
        end
      end
    end
  end
end

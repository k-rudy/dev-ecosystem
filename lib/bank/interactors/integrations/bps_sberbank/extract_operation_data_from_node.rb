module Bank
  module Interactors
    module Integrations
      module BpsSberbank
        class ExtractOperationDataFromNode
          include Hanami::Interactor

          expose :data

          def initialize(node:, user_id:)
            @node = node
            @user_id = user_id
          end

          def call
            @data = {
              account: account_data,
              operation: operation_data
            }
          end

          private

          def account_data
            {
              number: @node.css('accountinfo account').text,
              currency_iso: @node.css('accountinfo currency').attribute('iso').value,
              currency_code: @node.css('accountinfo currency').attribute('code').value,
              name: @node.css('accountinfo name').text
            }
          end

          # rubocop:disable AbcSize, MethodLength
          def operation_data
            {
              date: @node.css('accountinfo timeturn').attribute('date').value,
              time: @node.css('accountinfo timeturn').attribute('time').value,
              counteragent: counteragent_data,
              document_number: @node.css('accountinfo operinfo oper docn').text,
              currency_iso: @node.css('accountinfo currency').attribute('iso').value,
              currency_code: @node.css('accountinfo currency').attribute('code').value,
              currency_rate: @node.css('accountinfo currency').attribute('rate').value.to_f,
              value: operation_value,
              value_equivalent: equivalent_value,
              type: type,
              details: details,
              name: name
            }
          end
          # rubocop:enable AbcSize, MethodLength

          def counteragent_data
            {
              bank_code: @node.css('accountinfo operinfo oper mfokorr').text,
              bank_account: @node.css('accountinfo operinfo oper acckorr').text,
              name: @node.css('accountinfo operinfo oper namekorr').text,
              unp: @node.css('accountinfo operinfo oper unpkorr').text
            }
          end

          def operation_value
            attribute = debit? ? 'nd' : 'nk'
            @node.css('accountinfo operinfo oper sumoper').attribute(attribute).value
          end

          def debit?
            @debit ||= @node.css('accountinfo operinfo oper sumoper').attribute('nk').value.empty?
          end

          def equivalent_value
            attribute = debit? ? 'ed' : 'ek'
            @node.css('accountinfo operinfo oper sumoper').attribute(attribute).value
          end

          def details
            {
              detpay: @node.css('accountinfo operinfo oper detpay').text
            }
          end

          def type
            debit? ? 'debit' : 'credit'
          end

          def name
            type
          end
        end
      end
    end
  end
end

module Bank
  module Interactors
    module Integrations
      module BpsSberbank
        class ExtractOperationNodes
          include Hanami::Interactor

          attr_reader :file

          expose :nodes

          def initialize(file:)
            @file = file
          end

          def call
            @nodes = Nokogiri::HTML(file).css('turn').reject { |turn| turn.css('operinfo oper').empty? }
          end
        end
      end
    end
  end
end

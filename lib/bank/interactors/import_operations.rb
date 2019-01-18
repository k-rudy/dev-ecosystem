module Bank
  module Interactors
    class ImportOpeartions
      include Hanami::Interactor

      attr_reader :file, :node_to_operation_interactor

      def initialize(file:, convert_node_interactor:)
        @file = file
        @convert_node_interactor = convert_node_interactor
      end

      def call
        operation_nodes.each do |node|
          operation = convert_node_interactor.call(node)
        end
      end

      private

      def operation_nodes
        @operations || Nokogiri::HTML(file).css('turn').reject { |turn| turn.css('operinfo oper').empty? }
      end
    end
  end
end

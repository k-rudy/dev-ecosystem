module Bank
  module Interactors
    class ImportOperations
      include Hanami::Interactor

      attr_reader :file, :convert_node_interactor

      def initialize(file:, convert_node_interactor: ConvertNode)
        @file = file
        @convert_node_interactor = convert_node_interactor
      end

      def call
        operation_nodes.each do |node|
          convert_node_interactor.new(node: node).call
        end
      end

      private

      def operation_nodes
        @operations || Nokogiri::HTML(file).css('turn').reject { |turn| turn.css('operinfo oper').empty? }
      end
    end
  end
end

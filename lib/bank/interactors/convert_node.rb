module Bank
  module Interactors
    class ConvertNode
      include Hanami::Interactor

      attr_reader :node

      def initialize(node:)
        @node = node
      end

      def call; end
    end
  end
end

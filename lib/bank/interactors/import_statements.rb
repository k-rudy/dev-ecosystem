module Bank
  module Interactors
    class ImportStatements
      include Hanami::Interactor

      attr_reader :params

      def initialize(params:)
        @params = params
      end

      def call
        extract_xml
      end

      private

      def extract_xml
        @xml = Hash.from_xml(params[:file])
      end
    end
  end
end

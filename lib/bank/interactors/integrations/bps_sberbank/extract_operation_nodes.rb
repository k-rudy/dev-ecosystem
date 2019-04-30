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
            @nodes = turns.reject { |turn| turn.css('operinfo oper').empty? }
          end

          private

          def valid?
            error(I18n.t('errors.bps.invalid_file')) if turns.empty?
            !@errors || @orrors.empty?
          end

          def turns
            @turns ||= Nokogiri::HTML(file).css('turn')
          end
        end
      end
    end
  end
end

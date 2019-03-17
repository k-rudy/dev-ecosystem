RSpec.describe Bank::Interactors::ImportOperations do
  describe '#call' do
    let(:file_path) { 'spec/support/fixtures/testus.xml' }

    subject { described_class.new(file: File.open(file_path)).call }

    it 'extracts the list of turns' do
      subject
    end
  end
end

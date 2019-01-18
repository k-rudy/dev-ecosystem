RSpec.describe Bank::Interactors::ImportTurns do
  describe '#call' do
    let(:file_path) { 'spec/support/fixtures/turns.xml' }

    subject { described_class.new(file: File.open(file_path, 'r:cp866')).call }

    it 'extracts the list of turns' do
      subject
    end
  end
end

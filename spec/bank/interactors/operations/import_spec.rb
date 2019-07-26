RSpec.describe Bank::Interactors::Operations::Import do
  describe '#call' do
    let(:file_path) { 'spec/support/fixtures/bpsb.xml' }

    subject { described_class.new(file: File.open(file_path), user_id: 1).call }

    context 'when the file is not an xml file' do
      let(:file_path) { 'spec/support/fixtures/png.png' }

      it 'returns validation errors' do
        expect(subject.errors).to eq(['Файл не является файлом выписки БПС-Сбербанка.'])
      end
    end

    it 'succeeds' do
      expect(subject).to be_successful
    end

    it 'extracts the list of operations' do
      expect { subject }.to change { OperationRepository.new.operations.count }.by(6)
    end
  end
end

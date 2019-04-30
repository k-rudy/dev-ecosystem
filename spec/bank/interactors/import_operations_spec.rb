RSpec.describe Bank::Interactors::ImportOperations do
  describe '#call' do
    let(:file_path) { 'spec/support/fixtures/bpsb.xml' }

    subject { described_class.new(file: File.open(file_path), user_id: 1).call }

    context 'when the file is not an xml file' do
      let(:file_path) { 'spec/support/fixtures/png.png' }

      it 'returns validation errors' do
        expect(subject.errors).to eq(["Файл не является файлом выписки БПС-Сбербанка."])
      end
    end

    it 'extracts the list of operations' do
      subject
    end
  end
end

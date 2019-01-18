require 'spec_helper'

RSpec.describe BankUI::Views::ApplicationLayout, type: :view do
  let(:layout)   { BankUI::Views::ApplicationLayout.new({ format: :html }, 'contents') }
  let(:rendered) { layout.render }

  it 'contains application name' do
    expect(rendered).to include('Web')
  end
end

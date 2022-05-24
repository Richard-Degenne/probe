# frozen_string_literal: true

shared_context 'html' do # rubocop:disable RSpec/ContextWording
  let(:headers) do
    {
      'ACCEPT' => 'text/html',
      'Content-Type' => 'application/x-www-form-urlencoded'
    }
  end
end

shared_examples 'HTML response' do |status: :ok|
  its(:content_type) { is_expected.to eq 'text/html; charset=utf-8' }
  it { is_expected.to have_http_status status }
end

shared_context 'json' do # rubocop:disable RSpec/ContextWording
  let(:headers) do
    { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  end
end

shared_examples 'JSON response' do|status: :ok|
  its(:content_type) { is_expected.to eq 'application/json; charset=utf-8' }
  it { is_expected.to have_http_status status }
end

require 'paday'

RSpec.describe Paday do
  it { expect(described_class).to be_a Module }
  it { expect(described_class).to be < Roda }

  describe 'GET /' do
    it 'returns http success' do
      get '/'
      expect(last_response).to be_ok
    end

    it 'returns start message' do
      get '/'
      expect(last_response.body).to eq('{"status":"ok","start":"/{pages}/{percentage}"}')
    end

    it 'allows cors' do
      get '/'
      expect(last_response.headers['access-control-allow-origin']).to eq('*')
    end

    it 'only allows the get method' do
      get '/'
      expect(last_response.headers['access-control-allow-methods']).to eq('GET')
    end
  end

  describe 'GET /unkown' do
    it 'returns http not found' do
      get '/e'
      expect(last_response).to be_not_found
    end

    it 'returns an error message' do
      get '/e'
      expect(last_response.body).to eq('{"error":{"status":404,"message":"Page Not Found"}}')
    end
  end

  describe 'GET /208/4' do
    it 'returns http success' do
      get '/208/4'
      expect(last_response).to be_ok
    end

    it 'returns correct calculation' do
      get '/208/4'
      expect(last_response.body).to eq(
        "{\"pages\":8,\"days\":26,\"date\":\"#{(Date.today + 26).strftime('%d.%b.%Y')}\"}"
      )
    end

    it 'returns a JSON response' do
      get '/208/4'
      expect(last_response.content_type).to eq('application/json')
    end
  end
end

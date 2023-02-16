require 'paday'

RSpec.describe 'Paday' do
  describe 'GET /' do
    it 'returns http success' do
      get '/'
      expect(last_response).to be_ok
    end

    it 'returns start message' do
      get '/'
      expect(last_response.body).to eq('{"status":"ok","start":"/{pages}/{percentage}"}')
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
  end
end

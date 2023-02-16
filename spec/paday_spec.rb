require 'paday'

RSpec.describe Paday do
  it { expect(described_class).to be_a Module }
  it { expect(described_class).to be < Roda }

  describe 'GET /' do
    it 'returns http success' do
      get '/'
      expect(last_response.status).to eq(200)
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
      expect(last_response.status).to eq(404)
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

  describe 'GET /101/5' do
    it 'adds an extra day for extra pages' do
      get '/101/5'
      expect(last_response.body).to eq(
        "{\"pages\":5,\"days\":21,\"date\":\"#{(Date.today + 21).strftime('%d.%b.%Y')}\"}"
      )
    end
  end

  describe 'GET /11/5' do
    it 'returns a 500 status code' do
      get '/11/5'
      expect(last_response.status).to eq(500)
    end

    it 'returns an error message' do
      get '/11/5'
      expect(last_response.body).to eq(
        '{"error":{"status":500,"message":"Server Error","verbose":"divided by 0"}}'
      )
    end
  end
end

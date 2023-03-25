RSpec.describe Paday do
  let(:resp) { last_response }

  describe 'Paday' do
    subject { described_class }

    it { is_expected.to be_a Module }
    it { is_expected.to be < Roda }
  end

  describe 'GET /' do
    context 'when it loads' do
      before { get '/' }

      it 'returns http success' do
        expect(resp.status).to eq(200)
      end

      it 'returns start message' do
        expect(resp.body).to eq('{"status":"ok","start":"/{pages}/{percentage}"}')
      end

      it 'allows cors' do
        expect(resp.headers['access-control-allow-origin']).to eq('*')
      end

      it 'only allows the get method' do
        expect(resp.headers['access-control-allow-methods']).to eq('GET')
      end

      it 'returns the correct version number' do
        expect(resp.headers['accept']).to eq('version=1.0')
      end
    end
  end

  describe 'GET /pages/percentage' do
    context 'with valid params' do
      before { get '/208/4' }

      it 'returns http success' do
        expect(resp.status).to eq(200)
      end

      it 'returns correct calculation' do
        expect(resp.body).to eq(
          "{\"pages\":8,\"days\":26,\"date\":\"#{(Date.today + 26).strftime('%d.%b.%Y')}\"}"
        )
      end

      it 'returns a JSON response' do
        expect(resp.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      before { get '/11/5' }

      it 'returns a http server error' do
        expect(resp.status).to eq(500)
      end

      it 'returns an error message' do
        expect(resp.body).to eq(
          '{"error":{"status":500,"message":"Server Error","verbose":"divided by 0"}}'
        )
      end
    end

    context 'with both non integer parameters' do
      before { get '/fff/fff' }

      it 'returns http bad request' do
        expect(resp.status).to eq(400)
      end

      it 'returns an error message' do
        expect(resp.body).to eq(
          '{"error":{"status":400,"message":"Both pages and percentage must be integers"}}'
        )
      end
    end

    context 'with a percentage non integer parameter' do
      before { get '/450/fff' }

      it 'returns http bad request' do
        expect(resp.status).to eq(400)
      end

      it 'returns an error message' do
        expect(resp.body).to eq(
          '{"error":{"status":400,"message":"Both pages and percentage must be integers"}}'
        )
      end
    end

    context 'with a pages non integer parameter' do
      before { get '/fff/5' }

      it 'returns http bad request' do
        expect(resp.status).to eq(400)
      end

      it 'returns an error message' do
        expect(resp.body).to eq(
          '{"error":{"status":400,"message":"Both pages and percentage must be integers"}}'
        )
      end
    end

    context 'with one parameter' do
      before { get '/45' }

      it 'returns http server error' do
        expect(resp.status).to eq(500)
      end

      it 'return an error message' do
        expect(resp.body).to eq(
          '{"error":{"status":500,"message":"Server Error","verbose":"Two parameters (pages and percentage) are required"}}'
        )
      end
    end

    context 'with a remainder' do
      before { get '/101/5' }

      it 'returns http success' do
        expect(resp.status).to eq(200)
      end

      it 'adds an extra day for extra pages' do
        expect(resp.body).to eq(
          "{\"pages\":5,\"days\":21,\"date\":\"#{(Date.today + 21).strftime('%d.%b.%Y')}\"}"
        )
      end
    end
  end
end

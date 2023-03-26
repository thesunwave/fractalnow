# frozen_string_literal: true

require 'spec_helper'

describe FractalNow do
  include Rack::Test::Methods

  subject(:app) { described_class.new }

  describe 'POST /fractal' do
    context 'when the request is valid' do
      let(:config) do
        <<~CONFIG
          c075
          mandelbrot
          -6.999999999999999555910790149937383830547E-01 0E+00
          3.857142857142857142857142857142857142859E+00 3E+00
          1000 1000
          1
          0x0
          iterationcount
          smooth
          log
          0.45 0.2
          0 0x39a0 0.25 0xffffff 0.5 0xfffe43 0.75 0xbf0800 1 0x39a0
        CONFIG
      end
      let(:response) { post '/fractal', config }

      it 'returns a successful response' do
        expect(response.status).to eq(200)
      end

      it 'returns an image/png content type' do
        expect(response.content_type).to eq('image/x-portable-pixmap')
      end
    end

    context 'when the request is empty' do
      let(:response) { post '/fractal', '' }

      it 'returns a 400 Bad Request response' do
        expect(response.status).to eq(400)
      end

      it 'returns an error message in JSON format' do
        expect(response.content_type).to eq('application/json')
        expect(response.body).to eq({ error: 'Request can not be empty' }.to_json)
      end
      end

    context 'when the request is invalid' do
      let(:response) { post '/fractal', 'invalid' }

      it 'returns a 400 Bad Request response' do
        expect(response.status).to eq(500)
      end

      it 'returns an error message in JSON format' do
        expect(response.content_type).to eq('application/json')
        expect(response.body).to eq({ error: 'Error running fractalnow' }.to_json)
      end
    end
  end
end

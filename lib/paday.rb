require 'roda'

class Paday < Roda
  plugin :json
  plugin :default_headers,
         'Content-Type' => 'application/json',
         'Access-Control-Allow-Origin' => '*',
         'Access-Control-Allow-Methods' => 'GET',
         'Accept' => 'version=1.0'

  plugin :error_handler do |e|
    {
      error: {
        status: 500,
        message: 'Server Error',
        verbose: e.message
      }
    }
  end

  route do |r|
    r.root do
      { status: 'ok', start: '/{pages}/{percentage}' }
    end

    r.get Integer, Integer do |total_pages, percentage|
      pages = (percentage * total_pages) / 100
      extra_pages = (percentage * total_pages) % 100 != 0 && (total_pages / pages) * pages != total_pages
      days = extra_pages ? (total_pages / pages) + 1 : total_pages / pages
      date = Date.today + days
      {
        pages: pages,
        days: days,
        date: date.strftime('%d.%b.%Y')
      }
    end

    r.get(%r{(\d+)/(\D+)|(\D+)/(\d+)|(\D+)/(\D+)}) do |_, _, _, _, _, _|
      response.status = 400
      { error: { status: 400, message: 'Both pages and percentage must be integers' } }
    end

    r.get do
      raise ArgumentError, 'Two parameters (pages and percentage) are required'
    end
  end
end

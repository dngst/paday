require 'roda'

# Calculate pages, days & date
class Paday < Roda
  plugin :json
  plugin :default_headers,
         'Content-Type' => 'application/json',
         'Access-Control-Allow-Origin' => '*',
         'Access-Control-Allow-Methods' => 'GET',
         'Accept' => 'version=1.0'
  plugin :not_found do
    {
      error: {
        status: 404,
        message: 'Page Not Found'
      }
    }
  end
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
    # GET /
    r.root do
      {
        status: 'ok',
        start: '/{pages}/{percentage}'
      }
    end

    # GET /{pages}/{percentage}
    # Add an extra day for extra pages
    r.get Integer, Integer do |total_pages, percentage|
      pages = (percentage * total_pages) / 100
      days = if (percentage * total_pages) % 100 != 0 && (total_pages / pages) * pages != total_pages
               (total_pages / pages) + 1
             else
               total_pages / pages
             end
      date = Date.today + days
      {
        pages: pages,
        days: days,
        date: date.strftime('%d.%b.%Y')
      }
    end
  end
end

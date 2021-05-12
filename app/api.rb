require "sinatra"

class FacturaValidadorAPI < Sinatra::Base
  post "/dummy" do
    content_type :xml
    request.body
  end

  post "/almacenarFactura" do
  end
end

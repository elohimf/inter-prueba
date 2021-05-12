require "sinatra"

class FacturaValidadorAPI < Sinatra::Base
  post "/dummy" do
    content_type :xml
    request.body
  end

  post "/validarFactura" do
    content_type :xml
    200
  end

  post "/almacenarFactura" do
  end
end

require "sinatra"
require "./app/invoice"
require "./app/model/factura"
require "active_record"

class FacturaValidadorAPI < Sinatra::Base
  post "/dummy" do
    content_type :xml
    request.body
  end

  post "/validarFactura" do
    content_type :xml
    invoice = XSDInvoice.new(request.body)
    invoice.validate ? 200 : 450
  end

  post "/almacenarFactura" do
    content_type :xml
    invoice = XSDInvoice.new(request.body)
        200
  end
end

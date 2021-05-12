require "nokogiri"
require "./migrations"

describe FacturaValidadorAPI do
  let(:app) { FacturaValidadorAPI.new }

  context "validarFactura" do
    it "receives and prints xml" do
      # Solo se usa para probar que el servidor funcione de la forma mas simple posible. En produccion usualmente no añadiria esta prueba.
      invoice = Nokogiri::XML(File.open("facturas/invoice_example.xml"))
      post "/dummy", invoice.to_xml
      expect(last_response.status).to eq 200
    end

    it "receives and validates xml with status code 200" do
      invoice = Nokogiri::XML(File.open("facturas/invoice_example.xml"))
      post "/validarFactura", invoice.to_xml
      expect(last_response.status).to eq 200
    end

    it "receives and validates invalid xml with status code 450" do
      invoice = Nokogiri::XML(File.open("facturas/invoice_example_bad.xml"))
      post "/validarFactura", invoice.to_xml
      expect(last_response.status).to eq 450
    end
  end

  context "almacenarFactura" do
    it "stores xml for a report" do
    end
  end
end

require "nokogiri"

describe XSDInvoice do
  let(:xsd_invoice) { "facturas/invoice_example.xml" }
  let(:xsd_invoice_bad) { "facturas/invoice_example_bad.xml" }
  let(:namespaces) { {"xmlns:cfdi"=>"http://www.sat.gob.mx/cfd/3", "xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", "xmlns:tfd"=>"http://www.sat.gob.mx/TimbreFiscalDigital"}}

  context "new" do
    it "parses a good file" do
      expect { XSDInvoice.new(File.open(xsd_invoice)) }.not_to raise_error
      invoice = XSDInvoice.new(File.open(xsd_invoice))
      expect(invoice.namespaces).to eq namespaces
    end
    it "parses a bad file" do
      expect { XSDInvoice.new(File.open(xsd_invoice_bad)) }.not_to raise_error
      invoice = XSDInvoice.new(File.open(xsd_invoice_bad))
      expect(invoice.namespaces).to eq namespaces
    end
  end
  context "validate" do
  end
end

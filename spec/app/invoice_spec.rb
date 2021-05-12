require "nokogiri"

describe XSDInvoice do
  let(:xsd_invoice) { "facturas/invoice_example.xml" }
  let(:xsd_invoice_bad) { "facturas/invoice_example_bad.xml" }

  context "new" do
    it "parses a good file" do
      expect { XSDInvoice.new(File.open(xsd_invoice)) }.not_to raise_error
    end
    it "parses a bad file" do
    end
  end
  context "validate" do
  end
end

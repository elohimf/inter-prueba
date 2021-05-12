require "nokogiri"
require "open-uri"

class XSDInvoice
  attr_reader :invoice, :namespaces

  def initialize(invoice_xml)
    @options = Nokogiri::XML::ParseOptions.new.recover.nononet
    # Por ahora se considera al schema como 'trusted', aunque este endpoint es potencialmente inseguro.
    @schema = Nokogiri::XML::Schema.new(File.open("facturas/cfdv33.xsd.xml"), @options)
    @invoice = Nokogiri::XML(invoice_xml)
  end

  def validate
  end
end

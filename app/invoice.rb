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
    # El timbre es un schema diferente, por lo que se valida por separado
    timbre = @invoice.at_xpath("//tfd:TimbreFiscalDigital")
    timbreSchema = Nokogiri::XML::Schema(URI.open(timbre["xsi:schemaLocation"].split[1]), @options)
    timbre.remove_attribute("schemaLocation")
    invoice_copy = @invoice.clone
    invoice_copy.at_xpath("//cfdi:Complemento").remove

    @schema.validate(invoice_copy).empty? and timbreSchema.validate(Nokogiri::XML(timbre.to_xml)).empty?
  end
end

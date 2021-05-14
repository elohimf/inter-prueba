require "active_record"
require "./app/model/timbre"
require "./app/model/concepto"

class Factura < ActiveRecord::Base
  has_one :timbre
  has_many :conceptos

  def self.store(xsd_invoice)
    invoice = xsd_invoice.invoice
    emisor = invoice.at_xpath("//cfdi:Emisor")
    receptor = invoice.at_xpath("//cfdi:Receptor")
    comprobante = invoice.at_xpath("//cfdi:Comprobante")
    conceptos = invoice.search("//cfdi:Concepto")
    timbre = invoice.at_xpath("//tfd:TimbreFiscalDigital", xsd_invoice.namespaces)

    ActiveRecord::Base.transaction do
      Factura.create(
        rfc_emisor: emisor["Rfc"],
        nombre_emisor: emisor["Nombre"],
        regimen_fiscal_emisor: emisor["RegimenFiscal"],
        nombre_receptor: receptor["Nombre"],
        rfc_receptor: receptor["Rfc"],
        uso_cfdi_receptor: receptor["UsoCFDI"],
        serie: comprobante["Serie"],
        folio: comprobante["Folio"],
        fecha: comprobante["Fecha"],
        sello: comprobante["Sello"],
        forma_pago: comprobante["FormaPago"],
        numero_certificado: comprobante["NoCertificado"],
        certificado: comprobante["Certificado"],
        version: comprobante["Version"],
        subtotal: comprobante["SubTotal"],
        descuento: comprobante["Descuento"],
        moneda: comprobante["Moneda"],
        tipo_cambio: comprobante["TipoCambio"],
        total: comprobante["Total"],
        tipo_comprobante: comprobante["TipoDeComprobante"],
        metodo_pago: comprobante["MetodoPago"],
        cp_expedicion: comprobante["LugarExpedicion"]
      )

      Timbre.create(
        timbre_uuid: timbre["UUID"],
        version: timbre["Version"],
        fecha_timbrado: timbre["FechaTimbrado"],
        rfc_certificado: timbre["RfcProvCertif"],
        sello_cfd: timbre["SelloCFD"],
        numero_certificado_sat: timbre["NoCertificadoSAT"],
        sello_sat: timbre["SelloSAT"],
        factura_id: Factura.last.id,
      )

      conceptos.each do |concepto|
        Concepto.create(
          clave_prod_serv: concepto["ClaveProdServ"],
          cantidad: concepto["Cantidad"].to_i,
          clave_unidad: concepto["ClaveUnidad"],
          unidad: concepto["Unidad"],
          descripcion: concepto["Descripcion"],
          valor_unitario: concepto["ValorUnitario"],
          importe: concepto["Importe"],
          descuento: concepto["Descuento"],
          factura_id: Factura.last.id,
        )
      end
    end
  end
end

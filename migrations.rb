require 'active_record'


class CreateFacturasTable < ActiveRecord::Migration[5.2]
  def up
    unless ActiveRecord::Base.connection.table_exists?(:facturas)
      create_table :facturas do |table|
        table.string :rfc_emisor 
        table.string :nombre_emisor 
        table.string :regimen_fiscal_emisor 
        table.string :nombre_receptor 
        table.string :rfc_receptor 
        table.string :uso_cfdi_receptor 
        table.string :serie 
        table.string :folio 
        table.string :fecha 
        table.string :sello 
        table.string :forma_pago 
        table.string :numero_certificado 
        table.string :certificado 
        table.string :version 
        table.string :subtotal 
        table.string :descuento 
        table.string :moneda 
        table.string :tipo_cambio 
        table.string :total 
        table.string :tipo_comprobante 
        table.string :metodo_pago 
        table.string :cp_expedicion 
        table.timestamps
      end
    end
  end

  def down
    if ActiveRecord::Base.connection.table_exists?(:facturas)
      drop_table :facturas
    end
  end
end

class CreateTimbresTable < ActiveRecord::Migration[5.2]
  def up
    unless ActiveRecord::Base.connection.table_exists?(:timbres)
      create_table :timbres do |table|
        table.string :timbre_uuid 
        table.string :version 
        table.string :fecha_timbrado 
        table.string :rfc_certificado 
        table.string :sello_cfd 
        table.string :numero_certificado_sat 
        table.string :sello_sat 
        table.integer :factura_id
        table.timestamps
      end
    end
  end

  def down
    if ActiveRecord::Base.connection.table_exists?(:timbres)
      drop_table :timbres
    end
  end
end

class CreateConceptosTable < ActiveRecord::Migration[5.2]
  def up
    unless ActiveRecord::Base.connection.table_exists?(:conceptos)
      create_table :conceptos do |table|
        table.string :clave_prod_serv 
        table.integer :cantidad 
        table.string :clave_unidad 
        table.string :unidad 
        table.string :descripcion 
        table.string :valor_unitario 
        table.string :importe 
        table.string :descuento 
        table.integer :factura_id
        table.timestamps
      end
    end
  end

  def down
    if ActiveRecord::Base.connection.table_exists?(:conceptos)
      drop_table :conceptos
    end
  end
end

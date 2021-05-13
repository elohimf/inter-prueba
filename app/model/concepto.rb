require "active_record"

class Concepto < ActiveRecord::Base
  belongs_to :factura
end

require "active_record"

class Timbre < ActiveRecord::Base
  belongs_to :factura
end

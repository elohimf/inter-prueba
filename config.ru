require "yaml"
require "sqlite3"
require "active_record"
require "./config/environment"
require "./app/api"
require "./migrations"

db_config = YAML::load(File.open("./config/database.yaml"))
ActiveRecord::Base.establish_connection(db_config[ENV["RACK_ENV"]])
CreateFacturasTable.migrate(:up)
CreateTimbresTable.migrate(:up)
CreateConceptosTable.migrate(:up)
run FacturaValidadorAPI

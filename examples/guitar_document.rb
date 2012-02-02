require_relative '../lib/hashy_db/data_model'

class GuitarDocument
  include HashyDB::DataModel

  data_collection :guitars
  data_fields :brand, :price, :type, :color
end
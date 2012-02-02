require_relative 'guitar_document'

class Guitar
  attr_reader :brand, :price, :type, :color, :id

  def initialize(attrs)
    @brand = attrs[:brand]
    @price = attrs[:price]
    @type = attrs[:type]
    @color = attrs[:color]
  end

  def store
    @id = GuitarDocument.store(self)
  end
end
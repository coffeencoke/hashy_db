class Guitar
  attr_reader :brand, :price, :type, :color

  def initialize(attrs)
    @brand = attrs[:brand]
    @price = attrs[:price]
    @type = attrs[:type]
    @color = attrs[:color]
  end
end
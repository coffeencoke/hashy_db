class Guitar
  attr_reader :brand

  def initialize(attrs)
    @brand = attrs[:brand]
  end
end
class Array

  def select_by(attribute_name, value)
    self.select{ |obj| obj.send(attribute_name) == value }
  end

  def sum(attribute_name = nil)
    if attribute_name
      self.map{|obj| obj.send(attribute_name) }.compact.reduce(:+)
    else
      self.compact.reduce(:+)
    end
  end

end
class OjSerializer
  def self.serialize(array)
    Oj.dump(array, mode: :compat)
  end
end
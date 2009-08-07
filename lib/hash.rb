class Hash
  def without_default
    h = {}; for key, value in self
      h[key] = value
    end; h
  end
end
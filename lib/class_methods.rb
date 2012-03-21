module ActsAsCleo
  module ClassMethods
    def query(query, opts = {})
      Cleo.query(query)
    end
  end
end

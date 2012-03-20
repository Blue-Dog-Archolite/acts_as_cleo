module ActsAsCleo
  module CommonMethods
    def query(query, opts = {})
      Cleo.query(query)
    end

    def cleo_id
      record_type = self.cleo_config[:type]
      cr = Cleo::Reference.find_by_reference_and_id(record_type, self.id)
      return cr.nil? ? nil : cr.id
    end

    def cleo_id=( new_id)
      #this needs to be rerolled to pull an Cleo::Reference record and persist it.
    end
  end
end

module ActsAsCleo
  module InstanceMethods
    # callback hooks to keep cleo insync with data
    def sync_with_cleo
      if self.persisted?
        Cleo.update(self)
      else
        Cleo.create(self)
      end
      #after_update send the data to cleo
    end

    def set_cleo_id
      #this needs to be rerolled to pull an Cleo::Reference record and persist it.
    end

    def remove_from_cleo
      Cleo.delete(self) if self.persisted?
    end
    #end callback hooks

    def to_cleo_result
      #take self and change it into a Cleo::Result and return
      cr = Cleo::Result.new
      cr.term = []

      self.cleo_config[:terms].each do |term|
        cr.term << self.send(term).to_s
      end

      cr.term = cr.term.compact.reject(&:blank?)
      cr.id = self.cleo_id

      cr.name = self.send(self.cleo_config[:name]).to_s
      cr.name = cr.term.first if cr.name.blank?

      score = self.send(self.cleo_config[:score])
      cr.score = score.nil? ? 0 : score.count

      cr
    end

    alias :as_cleo :to_cleo_result
  end
end
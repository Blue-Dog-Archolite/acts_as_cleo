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

    def remove_from_cleo
      Cleo.delete(self) if self.persisted?
    end
    #end callback hooks

    def cleo_id
      return nil if self.id.nil?
      record_type = self.cleo_config[:type]
      cr = Cleo::Reference.find(:first, :conditions => ["record_type = ? and record_id = ?", record_type, self.id])

      return nil if cr.nil?
      return cr.id
    end

    def set_cleo_id
      #this needs to be rerolled to pull an Cleo::Reference record and persist it.
      cr = Cleo::Reference.find(:one, :conditions => ["record_type = ? and record_id = ?", record_type, self.id])
      cr = Cleo::Reference.create(:record_type => record_type, :record_id => self.id) if cr.nil?
    end#

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

      if score.nil?
        cr.score = 0
      elsif score.respond_to?("count")
        cr.score = score.count
      else
        cr.score = score
      end

      cr
    end

    alias :as_cleo :to_cleo_result
  end
end

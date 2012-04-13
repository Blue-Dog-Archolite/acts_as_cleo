module ActsAsCleo
  module InstanceMethods
    # callback hooks to keep cleo insync with data
    def create_cleo
      Cleo::ElementServer.create(self)
    end

    def update_cleo
      Cleo::ElementServer.update(self)
    end

    def remove_from_cleo
      cr = cleo_reference
      current_cleo_id = self.cleo_id
      cr.delete

      Cleo::ElementServer.delete(current_cleo_id)
    end

    def set_cleo_id
      cr = Cleo::Element.find(:first, :conditions => ["record_type = ? and record_id = ?", record_type, self.id])
      cr = Cleo::Element.create(:record_type => record_type, :record_id => self.id) if cr.nil?
    end#
    #end callback hooks

    def cleo_id
      return nil if self.id.nil?
      cr = cleo_reference

      return nil if cr.nil?
      return cr.id
    end

    def to_cleo_result
      #take self and change it into a Cleo::Xml::Result and return
      cr = Cleo::Xml::Result.new
      cr.term = []

      to_process = []

      self.cleo_config[:terms].each do |term|
        to_process << self.send(term).to_s.downcase
      end

      cr.term = clean_terms_for_storage(to_process).flatten

      set_cleo_id if self.cleo_id.nil? && !self.id.nil?
      cr.id = self.cleo_id

      cr.name = self.send(self.cleo_config[:name]).to_s.downcase
      cr.name = cr.term.first if cr.name.blank?

      cr.score = self.score


      cr
    end

    alias :as_cleo :to_cleo_result

    def score
      score = self.send(self.cleo_config[:score])
      if score.nil?
        return 0
      elsif score.respond_to?("count")
        return score.count
      end

      return score
    end


    def record_type
      self.cleo_config[:type]
    end

    def cleo_reference
      Cleo::Element.find(:first, :conditions => ["record_type = ? and record_id = ?", record_type, self.id])
    end

    private
    def clean_terms_for_storage(to_process)
      to_process = to_process.compact.flatten.reject(&:blank?)
      to_process.collect!{|i| i.split(/\s+/) }.compact.uniq
      to_process.reject{|i| drop_words.include?(i) }
    end

    def drop_words
      %w{and the this that no yes}
    end
  end
end

module ActsAsCleo
  module InstanceMethods
    # callback hooks to keep cleo insync with data
    def create_cleo
      set_cleo_id
      if Cleo::Server.async?
        Resque.enqueue(Cleo::Resque::Create, self.record_type.classify, self.id)
      else
        Cleo.create(self)
      end
    end

    def update_cleo
      if Cleo::Server.async?
        Resque.enqueue(Cleo::Resque::Update, self.record_type.classify, self.id)
      else
        Cleo.update(self)
      end
    end

    def remove_from_cleo
      if Cleo::Server.async?
        Resque.enqueue(Cleo::Resque::Delete, self.record_type.classify, self.id)
      else
        Cleo.delete(self.cleo_id)
        cr = cleo_reference
        cr.delete
      end
    end

    def set_cleo_id
      cr = Cleo::Reference.find(:first, :conditions => ["record_type = ? and record_id = ?", record_type, self.id])
      cr = Cleo::Reference.create(:record_type => record_type, :record_id => self.id) if cr.nil?
    end#
    #end callback hooks

    def cleo_id
      return nil if self.id.nil?
      cr = cleo_reference

      return nil if cr.nil?
      return cr.id
    end

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

    private
    def record_type
      self.cleo_config[:type]
    end

    def cleo_reference
      Cleo::Reference.find(:first, :conditions => ["record_type = ? and record_id = ?", record_type, self.id])
    end
  end
end

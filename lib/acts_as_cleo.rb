module Cleo::ActsAsCleo
  extend ActiveSupport::Concern

  ## Anything in here is done to all models
  # def self.included(base)
  #     base.before_create :set_cleo_id
  #     base.after_commit :sync_with_cleo
  #     base.after_destroy :remove_from_cleo
  #
  # end

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def acts_as_cleo(opts = {})
      class_eval <<-EOV
        include Cleo::ActsAsCleo::InstanceMethods
        before_create :set_cleo_id
        after_commit :sync_with_cleo
        after_destroy :remove_from_cleo

        cattr_accessor :cleo_config

        #set type to query against in Cleo
        #defaults to class name
        #ie "User" when acts_as_cleo is included in user.b
        self.cleo_config = {}
        self.cleo_config[:type] = opts[:type] || self.ancestors.first.name

        self.cleo_config[:name] = opts[:name]

        #specify what columns to add as part of the xml object
        #defaults to all columns in database
        self.cleo_config[:terms] = opts[:terms] || self.column_names
        self.cleo_config[:terms] = self.cleo_config[:terms] - opts[:except] unless opts[:except].blank?

        #figure out what the score param is. execute the self.send(#{opts[:score].to_s}.count)
        self.cleo_config[:score] = opts[:score]

        def query(query, opts = {})
          Cleo.query(query)
        end

        def cleo_id
          record_type = self.cleo_config[:type]
          return nil unless self.id
        end

        def cleo_id= ( new_id)
        end

      EOV

    end
  end


  module InstanceMethods
    # callback hooks to keep cleo insync with data
    def sync_with_cleo
      return if self.is_a?(Moderation)
      return if self.is_a?(Audit)

      if self.persisted?
        Cleo.update(self)
      else
        Cleo.create(self)
      end
      #after_update send the data to cleo
    end

    def set_cleo_id
      self.cleo_id = Time.now.to_i unless self.is_a?(Moderation) || self.is_a?(Audit)
    end

    def remove_from_cleo
      return if self.is_a?(Moderation)
      return if self.is_a?(Audit)
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
      self.cleo_id ||= Time.now.to_i
      cr.id = self.cleo_id || Time.now.to_i

      cr.name = self.send(self.cleo_config[:name]).to_s
      cr.name = cr.term.first if cr.name.blank?

      score = self.send(self.cleo_config[:score])
      cr.score = score.nil? ? 0 : score.count

      cr
    end

    alias :as_cleo :to_cleo_result
  end
end

ActiveRecord::Base.send :include, Cleo::ActsAsCleo

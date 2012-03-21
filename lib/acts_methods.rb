module ActsAsCleo
  module ActsMethods
    def acts_as_cleo(opts = {})
      #Common class methods added
      extend ClassMethods

      #Instance Methods Correctly Included
      include InstanceMethods

      after_commit  :set_cleo_id, :sync_with_cleo
      after_destroy :remove_from_cleo

      cattr_accessor :cleo_config

      #set type to query against in Cleo
      #defaults to class name
      #ie "User" when acts_as_cleo is included in user.b
      self.cleo_config = {}
      opts[:except] ||= []
      opts[:except] += %w{id created_at updated_at}
      self.cleo_config[:type] = opts[:type] || self.ancestors.first.name

      self.cleo_config[:name] = opts[:name].blank? ? "name" : opts[:name]

      #specify what columns to add as part of the xml object
      #defaults to all columns in database
      self.cleo_config[:terms] = opts[:terms] || self.column_names
      self.cleo_config[:terms] = self.cleo_config[:terms] - opts[:except]

      #figure out what the score param is. execute the self.send(#{opts[:score].to_s}.count)
      opts[:score] ||= "id"
      self.cleo_config[:score] = opts[:score]
    end
  end
end

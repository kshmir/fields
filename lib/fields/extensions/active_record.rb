if defined?(ActiveRecord::Base)
  ActiveRecord::Base.class_eval do
    def self.fields(include_in_migration = true, &b)
    end
  end
end

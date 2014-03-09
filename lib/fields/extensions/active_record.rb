if defined?(ActiveRecord::Base)
  ActiveRecord::Base.class_eval do
    def self.fields(include_in_migration = true, &b)
      @fields_table ||= Fields::Schema::Table.new(self.table_name)
      Fields::Schema::Dsl.new(@fields_table).instance_eval(&b)
    end
    def self.__fields__
      @fields_table
    end
  end
end

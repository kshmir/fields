module Fields
  class Schema
    class Differ
      class EMPTY; end
      Result = Struct.new(:actions)

      def initialize source, target
        @source_schema = source
        @target_schema = target
      end

      attr_accessor :source_schema, :target_schema

      def compute
        return Differ::EMPTY if source_schema == target_schema

        return Result.new(diff_schemas)
      end

      private
      def diff_schemas
        all_tables = (@source_schema.tables.keys + @target_schema.tables.keys).uniq
        all_tables.each do |k|
          source = @source_schema.tables[k]
          target = @target_schema.tables[k]
          
          compare_table(source, target) &&
            compare_columns(source.columns, target.columns)    
        end
        nil
      end

      def compare_columns source_columns, target_columns
        all_columns = (source_columns.keys + target_columns.keys).uniq
        all_columns.each do |k|
          source = source_columns[k]
          target = target_columns[k]
          compare_column(source, target)
        end
      end

      def compare_column source, target
      end

      def compare_table source, target
        if !source && target
          # New Table
          false
        elsif source && !target
          # Removed Table
          false
        else
          true
        end
      end
    end
  end
end

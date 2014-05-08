module Fields
  class Schema
    class Differ
      class EMPTY; end
      Result = Struct.new(:actions)
      Action = Struct.new(:action, :type)

      def initialize source, target
        @source_schema = source
        @target_schema = target
        @source_tables = source.tables
        @target_tables = target.tables
      end

      attr_accessor :source_schema, :target_schema

      def compute
        return Differ::EMPTY if source_schema == target_schema

        return Result.new(diff_schemas)
      end

      private
      def diff_schemas
        actions = []
        stack = [ 
          [:table, :columns],
          [:column, :extra_params],
          [:value]
        ]

        compare_stack stack, actions, @source_tables, @target_tables
      end

      def compare_stack stack, actions, source_hash = nil, target_hash = nil
        values = stack.pop
        all_keys = (source_hash.keys + target_hash.keys).uniq
        all_keys.each do |k|
          source = source_hash[k]
          target = target_hash[k]

          result = compare_entity(values[0], actions, source, target)
          method = values[1]

          if result && method
            compare_stack(stack, actions, source, target)
          end
        end
        actions
      end

      def compare_entity type, actions, source, target
        if !source && target
          actions << Action.new(:new, type)
          # New Table
        elsif source && !target
          # Removed Table
        elsif source != target
          actions << nil
          # Changed value
        else
          # No change
        end
      end
    end
  end
end

module Fields
  class Schema
    class Differ
      class EMPTY; end

      def initialize source, target
        @source_schema = source
        @target_schema = target
      end

      attr_accessor :source_schema, :target_schema

      def compute
        return Differ::EMPTY if source_schema == target_schema
      end

      private
    end
  end
end

require 'spec_helper'

module Fields
  class Schema
    describe Converter do
      subject do
        Converter.new
      end

      context "converting from an ActiveRecord's schema" do
        it "should respond to #from method" do
          expect(subject).to respond_to(:from)
        end
        context "parsing fields" do
        end
        context "parsing indexes" do
          it "should parse each index entry on the schema"
        end
      end
    end
  end
end


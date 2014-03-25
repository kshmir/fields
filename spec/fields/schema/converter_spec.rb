require 'spec_helper'

module Fields
  class Schema
    describe Converter do
      subject :converter do
        Converter.new
      end

      context "converting from an ActiveRecord's schema" do
        it "should respond to #from method" do
          expect(converter).to respond_to(:from)
        end
        context "parsing fields" do
          it "should parse the connection schemas" do
            ActiveRecord::Schema.define do
              create_table :authors do |t|
                t.string :name, :null => false
              end

              create_table :posts do |t|
                t.integer :author_id, :null => false
                t.string  :subject
                t.text    :body
                t.boolean :private, :default => false
              end
            end

            connection = ActiveRecord::Base.connection
            schema = converter.from(connection)

            schema.should be_a(Fields::Schema)
            schema.tables.size.should == connection.tables.size - 1
          end
        end
        context "parsing indexes" do
          it "should parse each index entry on the schema"
        end
      end
    end
  end
end


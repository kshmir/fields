require 'spec_helper'

module Fields
  class Schema
    describe Differ do
      subject :differ do
        @differ
      end

      subject :database_schema do
        @database_schema ||= begin
                      converter = Converter.new
                      silence_stream(STDOUT) do
                        ActiveRecord::Schema.define do
                          create_table :authors do |t|
                            t.string :name, :null => false
                          end
                        end
                      end
                      connection = ActiveRecord::Base.connection
                      schema = converter.from(connection)
                    end
      end

      subject :model_schema do
        @model_schema ||= begin
                      converter = Converter.new
                      silence_stream(STDOUT) do
                        ActiveRecord::Schema.define do
                          create_table :authors do |t|
                            t.string :changed_name, :null => false
                          end
                        end
                      end
                      connection = ActiveRecord::Base.connection
                      schema = converter.from(connection)
                    end
      end

      before :each do
        @differ = Differ.new database_schema, model_schema
      end

      context "#compare" do
        it "should have a source schema which comes from the database" do
          differ.should respond_to(:source_schema)
        end
        it "should have a target schema which comes from the models" do
          differ.should respond_to(:target_schema)
        end

        context "schema's columns" do
          context "same schema" do
            before :each do
              @differ = Differ.new model_schema, model_schema
            end
            it "should return the singleton Differ::EMPTY object" do
              differ.compute.should == Differ::EMPTY
            end
          end
          context "different schema" do
            it "should return an Differ::Result object"
            it "should allow diffing names"
            it "should allow diffing types"
            it "should allow diffing options"
          end
        end

        context "schema's indexes" do
          context "same schema" do
            it "should return the singleton Differ::EMPTY object"
          end
          context "different schema" do
            it "should return an Differ::Result object"
            # TODO: Define this further on
          end
        end
      end
    end
  end
end


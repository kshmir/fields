require 'spec_helper'

module Fields
  class Schema
    describe Differ do
      subject :differ do
        @differ
      end

      def build_schema &block
        converter = Converter.new
        silence_stream(STDOUT) do
          ActiveRecord::Schema.define(&block)
        end
        connection = ActiveRecord::Base.connection
        schema = converter.from(connection)
      end

      subject :database_schema do
        @database_schema ||=  build_schema do
          create_table :authors do |t|
            t.string :name, :null => false
          end
        end
      end

      subject :model_schema do
        @model_schema ||= build_schema do
          create_table :authors do |t|
            t.string :context, :null => false
          end
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

            before :each do
              @differ = Differ.new database_schema, model_schema
            end

            it "should return an Differ::Result object" do
              differ.compute.should be_a(Differ::Result)
            end

            context "diffing names" do
              context "adding a new name" do
                subject :model_schema do
                  @model_schema ||= build_schema do
                    create_table :authors do |t|
                      t.string :name, :null => false
                      t.string :title, :null => false
                    end
                  end
                end
                it "should return a result with a CreateColumnAction" do
                  differ.compute.actions.size.should == 1
                  differ.compute.actions.first.should == Differ::Action.new(:new, :column)
                end
              end

              context "changing a name" do
                it "should return a result with a ChooseAction"
              end

              context "deleting a name" do
                it "should return a result with a DeleteColumnAction"
              end
            end

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


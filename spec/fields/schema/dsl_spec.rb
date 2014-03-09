require 'spec_helper'

module Fields
  class Schema
    describe Dsl do
      subject :stub_table do
        double
      end
      subject :dsl do
        Dsl.new(stub_table)
      end
      
      it "should add a column by calling __field__" do
        expect(stub_table).to receive(:add_column)
        dsl.__field__(:name, :string)
      end

      it "should use method missing to declare new fields" do
        expect(stub_table).to receive(:add_column).with(:name, :string)
        dsl.name :string
      end

      context "any object that extends ActiveRecord::Base" do
        subject do
          Class.new(::ActiveRecord::Base) do
            self.table_name = "test"
          end
        end

        it "should have a new method called #fields" do
          subject.should respond_to(:fields)
        end

        it "should build a Fields::Schema::DSL from the fields declaration" do
          subject.class_eval do
            fields do
              name :string
            end
          end

          table = subject.__fields__

          table.should == begin
                            tab = Fields::Schema::Table.new("test")
                            tab.add_column :name, :string
                            tab
                          end
        end
      end
    end
  end
end

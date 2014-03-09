require 'fields'
require 'spec_helper'

module Fields
  class Schema
    describe Table do
      subject do
        Table.new(:users)
      end

      it "should store columns" do
        subject.add_column(:user, :integer, {}).object_id == subject.columns[:user].object_id
      end
      
      it "should raise a ColumnAlreadyExistsError when the same column is added twice" do
        subject.add_column(:user, :integer, {})
        expect {
          subject.add_column(:user, :integer, {})
        }.to raise_error(ColumnAlreadyExistsError)
      end

      context "equals method" do
        it "should fail if the name is different" do
          test_equals(subject, Table.new(:users))
          subject.should_not eq(Table.new(:products))
        end

        context "compares all the columns" do
          it "should fail if any column is different from the other" do
            column = double(:== => false)
            subject2 = Table.new(:users)
            subject2.stub(columns: { column => nil })
            subject.stub(columns:  { column => nil })
            subject.should_not eq(subject2)
          end

          it "should not fail when the names and columns are the same" do
            column = double(:== => true)
            subject2 = Table.new(:users)
            subject2.stub(columns: { column => nil })
            subject.stub(columns:  { column => nil })
            subject.should eq(subject2)
          end
        end
      end
    end
  end
end


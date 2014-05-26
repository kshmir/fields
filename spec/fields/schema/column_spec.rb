require 'spec_helper'

module Fields
  class Schema
    describe Column do
      context "has a working equals method" do
        it "should return true if all fields are the same" do
          objA = Column.new(:name, :type, {})
          objB = Column.new(:name, :type, {})
          test_equals(objA, objB)
        end
        it "should have a _simple_ equals method" do
          objA = Column.new(:name, :type, {})
          objB = Column.new(:name, :type, { b: 1 })
          objA.should eq(objB)
        end
      end
    end
  end
end

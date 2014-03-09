require 'fields'

module Fields
  class Schema
    describe Table do
      subject do
        Table.new(:users)
      end

      it "should store columns" do
        subject.add_column(:user, :integer, {}) == (Column.new(:user, :integer, {}))
      end
    end
  end
end


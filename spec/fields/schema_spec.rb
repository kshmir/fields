require 'spec_helper'

describe Fields::Schema do
  context ".add_table" do
    it "should only accept a symbol or a string" do
      expect {
         subject.add_table(1)
      }.to raise_error
      expect {
         subject.add_table("table")
      }.not_to raise_error
      expect {
         subject.add_table("")
      }.to raise_error
      expect {
         subject.add_table(:table)
      }.not_to raise_error
    end
    it "should store the table into the fields schema" do
      subject.add_table(:users)
      subject.tables.keys.include?(:users).should be_true
      subject.tables[:users].should_not be_nil
    end
  end
  context ".add_column" do
    it "should raise exception by default if no table is added" do
      expect { subject.add_column(:users, :name, :string) }.to raise_error
    end

    context "the table exists and is valid" do
      before :each do
        table = subject.add_table(:users)
        expect(table).to receive(:add_column).with(:name, :string, {})
      end

      it "should not throw exception otherwise" do
        expect { subject.add_column(:users, :name, :string) }.not_to raise_error
      end

      it "should store the column inside the table schema" do
        subject.add_column(:users, :name, :string)
      end
    end
  end
end

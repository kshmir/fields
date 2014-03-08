require 'fields'
require 'active_record'

describe Fields do
  it "should be a module" do
    Fields.class.should be(Module) 
  end
  it "has a schema object and a comparer for that schema" do
    Fields::Schema.class.should be(Class)
    Fields::Comparer.class.should be(Class)
  end
end

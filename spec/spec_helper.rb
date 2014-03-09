def test_equals(objA, objB, objC = nil)
  test_reflexivity(objA)
  test_reflexivity(objB)
  test_reflexivity(objC) if objC
  test_simmetry(objA, objB)
  test_simmetry(objA, objC) if objC
  test_transitivity(objA, objB, objC) if objC
end

def test_reflexivity(obj)
  obj.should eq(obj)
end

def test_simmetry(objA, objB)
  objA.should eq(objB)
  objB.should eq(objA)
end

def test_transitivity(objA, objB, objC)
  objA.should eq(objB)
  objB.should eq(objC)
end

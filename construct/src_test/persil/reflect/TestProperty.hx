package persil.reflect;

import massive.munit.Assert;

class TestProperty
{
	@Test
	public function getValue()
	{
		var instanceA = new persil.reflect.model.ClassA();
		var ci = ClassInfo.forInstance(instanceA);
		
		var a = ci.getProperty("a");
		Assert.isNull(a.getValue(instanceA));
		
		var c = ci.getProperty("c");
		Assert.areEqual(1, c.getValue(instanceA));
	}
	
	@Test
	public function setValue()
	{
		var instanceA = new persil.reflect.model.ClassA();
		var ci = ClassInfo.forInstance(instanceA);
		
		var newValue = 5;
		var a = ci.getProperty("a");
		a.setValue(instanceA, 5);
		Assert.areEqual(newValue, a.getValue(instanceA));
	}
}

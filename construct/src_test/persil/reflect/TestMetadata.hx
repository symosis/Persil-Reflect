package persil.reflect;

import massive.munit.Assert;

import persil.metadata.Metadata;

class TestMetadata
{
	@Test
	public function property()
	{
		var ci = ClassInfo.forClass(persil.reflect.model.ClassA);
		var a = ci.getProperty("a");
		var b = ci.getProperty("b");
		var c = ci.getProperty("c");
		Assert.isTrue(a.hasMetadata(Test));
		Assert.isFalse(b.hasMetadata(Test));
		Assert.isTrue(c.hasMetadata(Test));
	}
	
	@Test
	public function method()
	{
		var ci = ClassInfo.forClass(persil.reflect.model.ClassA);
		
		var f1 = ci.getMethod("f1");
		Assert.isTrue(f1.hasMetadata(Test));
		
		var f2 = ci.getMethod("f2");
		Assert.isFalse(f2.hasMetadata(Test));
	}
}

class Test extends Metadata
{
	public function new()
	{
		super();
		identifier = "Test";
	}
}
package persil.reflect;

import haxe.rtti.CType;
import haxe.rtti.Infos;

import massive.munit.Assert;

class TestClassInfo
{
	@Test
	public function testForClass()
	{
		var ci = ClassInfo.forClass(persil.reflect.model.ClassA);
		Assert.areEqual(persil.reflect.model.ClassA, ci.type);
	}
	
	@Test
	public function testForInstance()
	{
		var ci = ClassInfo.forInstance(new persil.reflect.model.ClassA());
		Assert.areEqual(persil.reflect.model.ClassA, ci.type);
	}
	
	@Test
	public function testForName()
	{
		var ci = ClassInfo.forName("persil.reflect.model.ClassA");
		Assert.areEqual(persil.reflect.model.ClassA, ci.type);
	}
	
	@Test
	public function testForCClassInt()
	{
		var type : CType = getCClassInt();
		var ci = ClassInfo.forCType(type);
		Assert.areEqual(ClassInfo.forClass(Int), ci);
	}
	
	@Test
	public function testNoRTTIModel()
	{
		var ci = ClassInfo.forClass(persil.reflect.model.NoRtti);
		
		Assert.areEqual(persil.reflect.model.NoRtti, ci.type);
		Assert.areEqual("persil.reflect.model.NoRtti", ci.name);
		Assert.areEqual(0, ci.properties.length);
		Assert.areEqual(0, ci.methods.length);
		Assert.isFalse(ci.hasRtti);
	}
	
	@Test
	public function testType()
	{
		var ci = ClassInfo.forClass(persil.reflect.model.ClassA);
		
		Assert.areEqual(persil.reflect.model.ClassA, ci.type);
		Assert.areEqual("persil.reflect.model.ClassA", ci.name);
		Assert.areEqual("ClassA", ci.shortName);
		Assert.isTrue(ci.hasRtti);
	}
	
	@Test
	public function testProperties()
	{
		var ci = ClassInfo.forClass(persil.reflect.model.ClassA);
		
		Assert.areEqual(3, ci.properties.length);
		Assert.areEqual("a", ci.getProperty("a").name);
		Assert.areEqual(ci, ci.getProperty("a").owner);
		Assert.areEqual(ClassInfo.forClass(Int), ci.getProperty("a").type);
		Assert.areEqual(Int, ci.getProperty("a").clazz);
	}
	
	@Test
	public function testEnum()
	{
		var ci = ClassInfo.forClass(persil.reflect.model.ClassA);
		
		Assert.areEqual("Bool", ci.getProperty("b").type.name);
	}
	
	@Test
	public function testMethods()
	{
		var ci = ClassInfo.forClass(persil.reflect.model.ClassA);
		
		Assert.areEqual(4, ci.methods.length);
		Assert.areEqual("f1", ci.getMethod("f1").name);
		Assert.areEqual(ClassInfo.forClass(Float), ci.getMethod("f1").type);
		Assert.areEqual(Float, ci.getMethod("f1").clazz);
		Assert.areEqual(1, ci.getMethod("f1").parameters.length);
		Assert.areEqual(ClassInfo.forClass(Int), ci.getMethod("f1").parameters[0].type);
	}
	
	private function getCClassInt() : CType
	{
		var infos = new haxe.rtti.XmlParser().processElement(Xml.parse(untyped CClassInt.__rtti).firstElement());
		var classDef : Classdef;
		switch(infos)
		{
			case TClassdecl(c): classDef = c;
			default:
				throw "error";
		}
		
		for(field in classDef.fields)
		{
			switch (field.type)
			{
				case CClass(name, params):
					return field.type;
				default:
					throw "error";
			}
			
		}
		
		throw "error";
	}
}

class CClassInt implements Infos
{
	public var int : Int;
}
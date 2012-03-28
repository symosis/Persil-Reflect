class TestSuite extends massive.munit.TestSuite
{		
	public function new()
	{
		super();
		add(persil.reflect.TestMetadata);
		add(persil.reflect.TestProperty);
		add(persil.reflect.TestClassInfo);
	}
}
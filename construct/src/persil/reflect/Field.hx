package persil.reflect;

import haxe.rtti.CType;
import haxe.rtti.Meta;

import persil.metadata.Metadata;

class Field implements MetadataAware
{
	public var owner(getOwner, null) : ClassInfo;
	public var name(getName, null) : String;
	public var type(getType, null) : ClassInfo;
	public var clazz(getClass, null) : Class<Dynamic>;
	
	private var field : ClassField;
	private var definedInClass : String;
	
	public function new(field : ClassField, definedInClass : String, owner : ClassInfo)
	{
		this.field = field;
		this.definedInClass = definedInClass;
		this.owner = owner;
	}
	
	public function hasMetadata(metadataClass : Class<Metadata>) : Bool
	{
		var metadata : Metadata = cast Type.createInstance(metadataClass, []);

		var declaredType = ClassInfo.forName(definedInClass);
		var metadatas = Meta.getFields(declaredType.type);
		
		for(fieldName in Reflect.fields(metadatas))
		{
			if (fieldName == this.name)
			{
				var meta = Reflect.field(metadatas, fieldName);
				if (Reflect.hasField(meta, metadata.identifier))
					return true;
			}
		}
				
		return false;
	}
	
	inline function getOwner() : ClassInfo
	{
		return owner;
	}
	
	inline function getName() : String
	{
		return field.name;
	}
	
	inline function getType() : ClassInfo
	{
		return ClassInfo.forCType(field.type);
	}
	
	function getClass() : Class<Dynamic>
	{
		var type = getType();
		return type == null ? null : type.type;
	}
}

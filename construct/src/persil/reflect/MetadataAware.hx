package persil.reflect;

import persil.metadata.Metadata;

interface MetadataAware
{
	public function hasMetadata(name : Class<Metadata>) : Bool;
}
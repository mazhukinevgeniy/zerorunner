package utils 
{
	import flash.utils.ByteArray;
	
	public function XMLByClass(item:Class):XML 
	{
		var code:ByteArray = new item() as ByteArray;
		return new XML(code.readUTFBytes(code.length));
	}

}
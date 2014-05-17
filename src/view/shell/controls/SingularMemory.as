package view.shell.controls 
{
	import starling.display.Sprite;
	
	public class SingularMemory extends Sprite
	{
		private var _type:int;
		
		public function SingularMemory(type:int) 
		{
			super();
			
			this._type = type;
		}
		
		public function get type():int
		{
			return _type;
		}
	}

}
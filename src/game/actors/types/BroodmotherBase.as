package game.actors.types 
{
	
	public class BroodmotherBase 
	{
		public static const EXTINCTING:int = 0;
		public static const APPEARING:int = 1;
		
		private var mode:int;
		
		private var type:Class;
		
		private var pull:Vector.<ActorBase>;
		
		public function BroodmotherBase()
		{
			
		}
		
		
	}

}
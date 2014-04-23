package game.items.generator 
{
	import game.GameElements;
	import game.items._utils.CheckpointPuppetBase;
	import game.metric.ICoordinated;
	
	internal class Generator extends CheckpointPuppetBase
	{
		
		public function Generator(master:GeneratorMaster, elements:GameElements, cell:ICoordinated) 
		{
			super(master, elements, cell);
		}
		
		override public function get type():int { return Game.ITEM_GENERATOR; }
	}

}
package game.world.items.fogs 
{
	import game.core.GameFoundations;
	import game.world.items.fogs.clouds.Cloud;
	import utils.updates.update;
	
	public class Fogs 
	{
		private var foundations:GameFoundations;
		
		private var clouds:Vector.<Cloud>;
		
		public function Fogs(foundations:GameFoundations) 
		{
			this.foundations = foundations;
			
			//TODO: initialize everything
		}
		
		update function prerestore():void
		{
			this.clouds = new Vector.<Cloud>();
			
			
			//DEBUG: like a test
			
			new FogPile(this.foundations);
			this.clouds.push(new Cloud());
		}
		
		update function freeFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_MOVE_CLOUDS)
			{
				var length:int = this.clouds.length;
				
				for (var i:int = 0; i < length; i++)
				{
					this.clouds[i].act();
				}
			}
		}
		
		//TODO: here be pooling of piles
	}

}
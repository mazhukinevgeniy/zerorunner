package game.world 
{
	import game.utils.GameFoundations;
	import game.world.broods.character.Character;
	import game.world.broods.checkpoint.Checkpoint;
	import game.world.broods.fog.Fog;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.skyClearer.SkyClearer;
	import game.world.broods.technic.Technic;
	import game.world.broods.utils.PointsOfInterest;
	import game.world.operators.ActorOperators;
	import utils.updates.update;
	
	use namespace update;
	
	public class ActorsFeatures extends SceneFeatures
	{
		private var actors:Vector.<ItemLogicBase>;
		
		private var foundations:GameFoundations;
		
		
		public function ActorsFeatures(foundations:GameFoundations) 
		{
			super(foundations.game);
			
			this.foundations = foundations;
			
			new ActorOperators();
		}
		
		override update function prerestore():void
		{
			super.update::prerestore();
			
			//TODO: clean the cache...
			
			
			new PointsOfInterest();
			
			new Character();
			new Checkpoint();
			new Fog();
			new SkyClearer();
			new Technic();
		}
	}

}
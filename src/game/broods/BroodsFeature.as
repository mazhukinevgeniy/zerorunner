package game.broods 
{
	import game.broods.character.Character;
	import game.broods.checkpoint.Checkpoint;
	import game.broods.fog.Fog;
	import game.broods.skyClearer.SkyClearer;
	import game.broods.technic.Technic;
	import game.epicenter.ISearcher;
	import game.utils.GameFoundations;
	import utils.templates.UpdateGameBase;
	import utils.updates.update;
	
	public class BroodsFeature implements IGiveBroods, IGiveTowers
	{
		public static const CHARACTER:int = 0;
		public static const CHECKPOINT:int = 1;
		public static const FOG:int = 2;
		public static const SKY_CLEARER:int = 3;
		public static const TECHNIC:int = 4;
		
		private static const NUMBER_OF_BROODS:int = 5;
		private static const NUMBER_OF_TOWERS:int = 1;
		
		private var broods:Vector.<BroodmotherBase>;
		private var towers:Vector.<IGiveTowers>;
		
		public function BroodsFeature(foundations:GameFoundations, world:ISearcher) 
		{
			BroodmotherBase.juggler = foundations.juggler;
			BroodmotherBase.gameAtlas = foundations.atlas;
			BroodmotherBase.flow = foundations.flow;
			BroodmotherBase.world = world;
			
			this.broods = new Vector.<BroodmotherBase>(BroodsFeature.NUMBER_OF_BROODS, true);
			
			this.broods[BroodsFeature.CHARACTER] = new Character(foundations.input);
			this.broods[BroodsFeature.CHECKPOINT] = new Checkpoint();
			this.broods[BroodsFeature.FOG] = new Fog();
			this.broods[BroodsFeature.SKY_CLEARER] = new SkyClearer();
			this.broods[BroodsFeature.TECHNIC] = new Technic(this);
			
			this.towers = new Vector.<IGiveTowers>(BroodsFeature.NUMBER_OF_TOWERS, true);
			this.towers[0] = this.broods[BroodsFeature.SKY_CLEARER] as IGiveTowers;
			
			foundations.flow.workWithUpdateListener(this);
			foundations.flow.addUpdateListener(UpdateGameBase.prerestore);
		}
		
		update function prerestore():void
		{
			for (var i:int = 0; i < BroodsFeature.NUMBER_OF_BROODS; i++)
				this.broods[i].reset();
		}
		
		
		public function getBrood(type:int):BroodmotherBase
		{
			return this.broods[type];
		}
		
		public function getRandomTower():ItemLogicBase
		{
			return this.towers[int(Math.random() * BroodsFeature.NUMBER_OF_TOWERS)].getRandomTower();
		}
	}

}
package game.actors.manipulator 
{
	import game.actors.ActorsFeature;
	import game.actors.manipulator.actions.*;
	import game.actors.manipulator.checks.*;
	import game.actors.manipulator.moves.*;
	import game.actors.manipulator.onDamaged.*;
	import game.actors.storage.ISearcher;
	import chaotic.core.IUpdateDispatcher;
	import game.grinder.IGrinder;
	import chaotic.informers.IGiveInformers;
	import game.input.IKnowInput;
	import game.scene.IScene;
	
	internal class ActionFactory
	{
		private var actions:Object;
		private var flow:IUpdateDispatcher;
		
		public function ActionFactory(flow:IUpdateDispatcher) 
		{
			this.flow = flow;
			this.actions = new Object();
		}
		
		internal function getAction(name:String):ActionBase
		{
			return this.actions[name];
		}
		
		internal function getInformerFrom(table:IGiveInformers, performer:IActionPerformer):void
		{
			var scene:IScene = table.getInformer(IScene);
			var actors:ISearcher = table.getInformer(ISearcher);
			var grinder:IGrinder = table.getInformer(IGrinder);
			var input:IKnowInput = table.getInformer(IKnowInput);
			var updateFlow:IUpdateDispatcher = this.flow;
			
			var bite:Bite = new Bite(performer, actors);
			var detonate:Detonate = new Detonate(actors, performer);
			
			this.actions["DoNothing"] = new DoNothing();
			
			this.actions["ProtagonistDamaged"] = new ProtagonistDamaged(updateFlow);
			
			this.actions["IsGrindedCheck"] = new IsGrindedCheck(grinder, performer);
			this.actions["NormalLandscapeCheck"] = new NormalLandscapeCheck(scene, performer);
			this.actions["OutOfBoundsCheck"] = new OutOfBoundsCheck(performer, actors);
			
			this.actions["HeuristicGoalPursuing"] = new HeuristicGoalPursuing(scene, actors, performer, detonate);
			this.actions["InertialRandom"] = new InertialRandom(performer, actors);
			this.actions["MoveLikeACharacter"] = new MoveLikeACharacter(scene, input, performer, actors, updateFlow);
			this.actions["RunForward"] = new RunForward(performer, actors, scene, bite);
			this.actions["SearchCorridor"] = new SearchCorridor(scene, performer, actors);
		}
	}

}
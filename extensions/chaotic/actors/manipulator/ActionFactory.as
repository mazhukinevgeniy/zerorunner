package chaotic.actors.manipulator 
{
	import chaotic.actors.ActorsFeature;
	import chaotic.actors.manipulator.checks.*;
	import chaotic.actors.manipulator.moves.*;
	import chaotic.actors.manipulator.onBlocked.*;
	import chaotic.actors.manipulator.onDamaged.*;
	import chaotic.actors.manipulator.onSpawned.*;
	import chaotic.actors.storage.ISearcher;
	import chaotic.core.IUpdateDispatcher;
	import chaotic.grinder.IGrinder;
	import chaotic.informers.IGiveInformers;
	import chaotic.input.IKnowInput;
	import chaotic.scene.IScene;
	
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
			
			this.actions["DoNothing"] = new DoNothing();
			
			this.actions["ReachGrinder"] = new ReachGrinder(performer, grinder, actors);
			
			this.actions["Detonate"] = new Detonate(actors, performer);
			this.actions["Bite"] = new Bite(performer, actors);
			
			this.actions["ProtagonistDamaged"] = new ProtagonistDamaged(updateFlow);
			
			this.actions["IsGrindedCheck"] = new IsGrindedCheck(grinder, performer);
			this.actions["NormalLandscapeCheck"] = new NormalLandscapeCheck(scene, performer);
			this.actions["OutOfBoundsCheck"] = new OutOfBoundsCheck(performer, actors);
			
			this.actions["HeuristicGoalPursuing"] = new HeuristicGoalPursuing(scene, actors, performer);
			this.actions["InertialRandom"] = new InertialRandom(performer, actors);
			this.actions["MoveLikeACharacter"] = new MoveLikeACharacter(scene, input, performer, actors);
			this.actions["RunForward"] = new RunForward(performer, actors, scene);
			this.actions["SearchCorridor"] = new SearchCorridor(scene, performer, actors);
		}
	}

}
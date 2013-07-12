package game.actors.manipulator 
{
	import game.actors.ActorsFeature;
	import game.actors.manipulator.actions.*;
	import game.actors.manipulator.checks.*;
	import game.actors.manipulator.moves.*;
	import game.actors.storage.ISearcher;
	import chaotic.core.IUpdateDispatcher;
	import game.grinder.IGrinder;
	import chaotic.informers.IGiveInformers;
	import game.input.IKnowInput;
	import game.scene.IScene;
	
	internal class ActionFactory
	{
		private var actions:Object;
		
		public function ActionFactory(flow:IUpdateDispatcher) 
		{
			ActionBase.flow = flow;
			
			
			this.actions = new Object();
		}
		
		internal function getAction(name:String):ActionBase
		{
			return this.actions[name];
		}
		
		internal function getInformerFrom(table:IGiveInformers):void
		{
			var scene:IScene = table.getInformer(IScene);
			var grinder:IGrinder = table.getInformer(IGrinder);
			var input:IKnowInput = table.getInformer(IKnowInput);
			
			ActionBase.searcher = table.getInformer(ISearcher);
			
			var bite:Bite = new Bite();
			
			this.actions["IsGrindedCheck"] = new IsGrindedCheck(grinder);
			this.actions["NormalLandscapeCheck"] = new NormalLandscapeCheck(scene);
			this.actions["OutOfBoundsCheck"] = new OutOfBoundsCheck();
			
			var kick:Kick = new Kick(this.actions["NormalLandscapeCheck"]);
			
			this.actions["HeuristicGoalPursuing"] = new HeuristicGoalPursuing(scene, bite);
			this.actions["InertialRandom"] = new InertialRandom();
			this.actions["MoveLikeACharacter"] = new MoveLikeACharacter(scene, input, ActionBase.flow, kick);
			this.actions["RunForward"] = new RunForward(scene, bite);
			this.actions["SearchCorridor"] = new SearchCorridor(scene);
		}
	}

}
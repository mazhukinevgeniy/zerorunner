package game.items.base 
{
	import data.viewers.GameConfig;
	import game.core.metric.*;
	import game.GameElements;
	import game.items.base.cores.ContraptionCore;
	import game.items.base.cores.ElectricityCore;
	import game.items.base.cores.ExistenceCore;
	import game.items.base.cores.RespawnCore;
	import game.items.IActors;
	import game.items.IActorTracker;
	import game.scene.IScene;
	import starling.display.DisplayObject;
	import utils.updates.IUpdateDispatcher;
	
	public class ItemLogicBase implements ICoordinated
	{
		protected var _contraption:ContraptionCore;
		protected var _electricity:ElectricityCore;
		protected var _existence:ExistenceCore;
		protected var _respawn:RespawnCore;
		
		
		
		protected var actors:IActors;
		protected var scene:IScene;
		protected var config:GameConfig;
		
		private var actorTracker:IActorTracker;
		
		private var view:ItemViewBase;
		
		public function ItemLogicBase(cell:CellXY, view:ItemViewBase, foundations:GameElements) 
		{
			/*
			const width:int = this.config.width;
			
			var cell:CellXY = Metric.getTmpCell(Game.BORDER_WIDTH + Math.random() * width, 
												Game.BORDER_WIDTH + Math.random() * width);
			
			for (; this.actors.findObjectByCell(cell.x, cell.y); )
				cell.setValue(Game.BORDER_WIDTH + Math.random() * width, Game.BORDER_WIDTH + Math.random() * width);
			
			return cell; * 
			 * */
			//TODO: find where to generate spawning cell
			
			this.view = view;
			
			this.scene = foundations.scene;
			this.actors = foundations.actors;
			this.config = foundations.database.config;
			
			this.actorTracker = foundations.actorsTracker;
			
			//TODO: set all cores
		}
		
		public function act():void
		{
			
		}
		
		
		
		
		final public function get contraption():ContraptionCore { return this._contraption; }
		final public function get electricity():ElectricityCore { return this._electricity; }
		final public function get existence():ExistenceCore { return this._existence; }
		final public function get respawn():RespawnCore { return this._respawn; }
		
		
		/**
		 * for the external use
		 */
		
		final public function getView():DisplayObject
		{
			return this.view;
		}
	}

}
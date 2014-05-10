package view.game 
{
	import binding.IBinder;
	import controller.observers.game.IGameFrameHandler;
	import controller.observers.game.INewGameHandler;
	import controller.observers.game.IQuitGameHandler;
	import controller.observers.map.IMapFrameHandler;
	import controller.observers.map.IMapStatusObserver;
	import flash.utils.ByteArray;
	import model.interfaces.IInput;
	import model.interfaces.IScene;
	import model.interfaces.IStatus;
	import model.metric.DCellXY;
	import model.metric.ICoordinated;
	import model.utils.normalize;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.utils.Color;
	
	public class MapFeature implements INewGameHandler,
	                                   IQuitGameHandler,
	                                   IGameFrameHandler, 
									   IMapFrameHandler, 
									   IMapStatusObserver
	{
		private const C_WIDTH:int = 7;
		private const BORDER_WIDTH:int = 45;
		
		private const NOT_VISITED:int = 0;
		private const VISITED:int = 1;
		
		private var visited:ByteArray;
		
		private var scene:IScene;
		private var status:IStatus;
		
		private var input:IInput;
		
		private var container:QuadBatch;
		
		private var tiles:Array;
		
		private var minX:int;
		private var maxX:int = 0;
		private var minY:int;
		private var maxY:int = 0;
		
		public function MapFeature(binder:IBinder, root:DisplayObjectContainer) 
		{
			binder.notifier.addGameStatusObserver(this);
			binder.notifier.addMapStatusObserver(this);
			
			this.visited = new ByteArray();
			//TODO: move to the model
			
			this.scene = binder.scene;
			this.input = binder.input;
			
			this.status = binder.gameStatus;
			
			this.tiles = new Array();
			this.tiles[Game.SCENE_FALL] = new Quad(this.C_WIDTH, this.C_WIDTH, 0x000000);
			this.tiles[Game.SCENE_TR_DISK] = new Quad(this.C_WIDTH, this.C_WIDTH, 0x000000);
			this.tiles[Game.SCENE_TL_DISK] = new Quad(this.C_WIDTH, this.C_WIDTH, 0x000000);
			this.tiles[Game.SCENE_BR_DISK] = new Quad(this.C_WIDTH, this.C_WIDTH, 0x000000);
			this.tiles[Game.SCENE_BL_DISK] = new Quad(this.C_WIDTH, this.C_WIDTH, 0x000000);
			this.tiles[Game.SCENE_GROUND] = new Quad(this.C_WIDTH, this.C_WIDTH, 0x8B4513);
			
			this.container = new QuadBatch();
			root.addChild(this.container);
		}
		
		public function newGame():void
		{
			this.container.reset();
			
			var i:int;
			
			var length:int = this.visited.length = Game.MAP_WIDTH * Game.MAP_WIDTH;
			
			for (i = 0; i < length; i++)
				this.visited[i] = this.NOT_VISITED;
				/* OPTIMIZABLE */
			
			this.container.reset();
			this.container.visible = false;
			
			var borderPiece:Quad = new Quad(this.BORDER_WIDTH, this.BORDER_WIDTH, Color.NAVY);
			
			const MAX_WIDTH:int = Game.MAP_WIDTH * this.C_WIDTH + 2 * this.BORDER_WIDTH;
			
			if ((Game.MAP_WIDTH * this.C_WIDTH) % this.BORDER_WIDTH != 0)
				throw new Error("can't render map borders");
			
			for (i = 0; i < MAX_WIDTH; i += this.BORDER_WIDTH)
			{
				borderPiece.y = 0;
				borderPiece.x = i;
				
				this.container.addQuad(borderPiece);
				
				borderPiece.y = MAX_WIDTH - this.BORDER_WIDTH;
				
				this.container.addQuad(borderPiece);
				
				borderPiece.x = 0;
				borderPiece.y = i;
				
				this.container.addQuad(borderPiece);
				
				borderPiece.x = MAX_WIDTH - this.BORDER_WIDTH;
				
				this.container.addQuad(borderPiece);
			}
			
			var back:Quad = new Quad(MAX_WIDTH - 2 * this.BORDER_WIDTH,
									 MAX_WIDTH - 2 * this.BORDER_WIDTH,
									 0xADD8E6);
			back.x = back.y = this.BORDER_WIDTH;
			
			this.container.addQuad(back);
			
			this.minX = -(MAX_WIDTH - Main.WIDTH);
			this.minY = -(MAX_WIDTH - Main.HEIGHT);
			
			this.gameFrame(Game.FRAME_TO_UNLOCK_ACHIEVEMENTS);
		}
		
		public function setVisibilityOfMap(visible:Boolean):void
		{
			this.container.visible = visible;
		}
		
		public function gameFrame(key:int):void
		{
			if (key == Game.FRAME_TO_UNLOCK_ACHIEVEMENTS)
			{
				var center:ICoordinated = this.status.getLocationOfHero();
				
				var iGoal:int = center.x + 8;
				var jGoal:int = center.y + 6;
				
				for (var i:int = center.x - 7; i < iGoal; i++)
					for (var j:int = center.y - 5; j < jGoal; j++)
					{
						var nI:int = normalize(i);
						var nJ:int = normalize(j);
						
						if (this.visited[nI + Game.MAP_WIDTH * nJ] == this.NOT_VISITED)
						{
							this.visited[nI + Game.MAP_WIDTH * nJ] = this.VISITED;
							
							var quad:Quad = this.tiles[this.scene.getSceneCell(i, j)];
							
							quad.x = this.BORDER_WIDTH + this.C_WIDTH * nI;
							quad.y = this.BORDER_WIDTH + this.C_WIDTH * nJ;
							
							this.container.addQuad(quad);
						}
					}
			}
		}
		
		public function mapFrame():void
		{
			var input:Vector.<DCellXY> = this.input.getInputCopy();
			var action:DCellXY = input.pop();
			
			const STEP:int = 4;
			
			while (action && (action.x + action.y != 0))/* implying it's 0 if both are 0 */
			{
				this.container.x -= STEP * action.x;
				this.container.y -= STEP * action.y;
				
				action = input.pop();
			}
			
			if (this.container.x < this.minX)
				this.container.x = this.minX;
			else if (this.container.x > this.maxX)
				this.container.x = this.maxX;
			
			if (this.container.y < this.minY)
				this.container.y = this.minY;
			else if (this.container.y > this.maxY)
				this.container.y = this.maxY;
		}
		
		public function quitGame():void
		{
			this.container.reset();
			
			this.visited.clear();
			
			this.container.visible = false;
		}
	}

}
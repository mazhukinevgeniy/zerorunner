package view.game 
{
	import binding.IBinder;
	import controller.observers.IGameFrameHandler;
	import controller.observers.IGameMapObserver;
	import controller.observers.IMapFrameHandler;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import feathers.controls.Screen;
	import flash.utils.ByteArray;
	import model.interfaces.IExploration;
	import model.interfaces.IInput;
	import model.interfaces.IScene;
	import model.interfaces.IStatus;
	import model.metric.DCellXY;
	import model.metric.ICoordinated;
	import model.utils.normalize;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.utils.Color;
	
	internal class MapScreen extends Screen implements INewGameHandler,
	                                                   IQuitGameHandler,
													   IMapFrameHandler,
													   IGameMapObserver
	{
		private const C_WIDTH:int = 7;
		private const BORDER_WIDTH:int = 45;
		
		private var input:IInput;
		private var exploration:IExploration;
		
		private var container:QuadBatch;
		
		private var tiles:Array;
		
		private var minX:int;
		private var maxX:int = 0;
		private var minY:int;
		private var maxY:int = 0;
		
		public function MapScreen(binder:IBinder) 
		{
			super();
			
			binder.notifier.addObserver(this);
			
			this.input = binder.input;
			this.exploration = binder.exploration;
			
			this.tiles = new Array();
			this.tiles[Game.SCENE_FALL] = new Quad(this.C_WIDTH, this.C_WIDTH, 0x000000);
			this.tiles[Game.SCENE_DISK] = new Quad(this.C_WIDTH, this.C_WIDTH, 0x000000);
			this.tiles[Game.SCENE_GROUND] = new Quad(this.C_WIDTH, this.C_WIDTH, 0x8B4513);
			this.tiles[Game.SCENE_NONE] = new Quad(0, 0, 0x000000);
			
			this.container = new QuadBatch();
			this.addChild(this.container);
		}
		
		public function newGame():void
		{
			this.container.reset();
			
			var borderPiece:Quad = new Quad(this.BORDER_WIDTH, this.BORDER_WIDTH, Color.NAVY);
			
			const MAX_WIDTH:int = Game.MAP_WIDTH * this.C_WIDTH + 2 * this.BORDER_WIDTH;
			
			if ((Game.MAP_WIDTH * this.C_WIDTH) % this.BORDER_WIDTH != 0)
				throw new Error("can't render map borders");
			
			var i:int;
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
			
			this.minX = -(MAX_WIDTH - View.WIDTH);
			this.minY = -(MAX_WIDTH - View.HEIGHT);
		}
		
		public function showGameMap():void
		{
			var quad:Quad;
			
			this.container.reset();
			
			for (var x:int = 0; x < Game.MAP_WIDTH; x++)
				for (var y:int = 0; y < Game.MAP_WIDTH; y++)
				{
					quad = this.tiles[this.exploration.getExplored(x, y)];
					
					quad.x = this.BORDER_WIDTH + x * this.C_WIDTH;
					quad.y = this.BORDER_WIDTH + y * this.C_WIDTH;
					
					this.container.addQuad(quad);
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
		}
	}

}
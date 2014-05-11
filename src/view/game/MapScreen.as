package view.game 
{
	import binding.IBinder;
	import controller.observers.IGameMapObserver;
	import controller.observers.IMapFrameHandler;
	import controller.observers.IQuitGameHandler;
	import feathers.controls.Screen;
	import model.interfaces.IExploration;
	import model.interfaces.IInput;
	import model.metric.DCellXY;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.utils.Color;
	
	internal class MapScreen extends Screen implements IQuitGameHandler,
													   IMapFrameHandler,
													   IGameMapObserver
	{
		private const C_WIDTH:int = 8;
		
		private var input:IInput;
		private var exploration:IExploration;
		
		private var container:QuadBatch;
		
		private var tiles:Array;
		private var back:Quad;
		
		public function MapScreen(binder:IBinder) 
		{
			super();
			binder.notifier.addObserver(this);
			
			this.container = new QuadBatch();
			
			this.input = binder.input;
			this.exploration = binder.exploration;
			
			this.tiles = new Array();
			this.tiles[Game.SCENE_FALL] = new Quad(this.C_WIDTH, this.C_WIDTH, 0x000000);
			this.tiles[Game.SCENE_DISK] = new Quad(this.C_WIDTH, this.C_WIDTH, 0x000000);
			this.tiles[Game.SCENE_GROUND] = new Quad(this.C_WIDTH, this.C_WIDTH, 0x8B4513);
			this.tiles[Game.SCENE_NONE] = new Quad(0, 0, 0x000000);
			
			this.back = new Quad(this.C_WIDTH * Game.MAP_WIDTH, this.C_WIDTH * Game.MAP_WIDTH,
								 Color.SILVER);
			
			this.addChild(this.container);
		}
		
		public function showGameMap():void
		{
			var quad:Quad;
			
			this.container.reset();
			this.container.addQuad(this.back);
			
			for (var y:int = 0; y < Game.MAP_WIDTH; y++)
				for (var x:int = 0; x < Game.MAP_WIDTH; x++)
				{
					quad = this.tiles[this.exploration.getExplored(x, y)];
					
					quad.x = x * this.C_WIDTH;
					quad.y = y * this.C_WIDTH;
					
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
			
			var x:int = this.container.x;
			var y:int = this.container.y;
			
			const minX:int = -(Game.MAP_WIDTH * this.C_WIDTH - View.WIDTH);
			const minY:int = -(Game.MAP_WIDTH * this.C_WIDTH - View.HEIGHT);
			
			x = x > 0 ? 0 : x < minX ? minX : x;
			y = y > 0 ? 0 : y < minY ? minY : y;
			
			this.container.x = x;
			this.container.y = y;
		}
		
		
		
		public function quitGame():void
		{
			this.container.reset();
		}
	}

}
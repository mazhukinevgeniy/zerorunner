package game.hud 
{
	import data.viewers.GameConfig;
	import flash.utils.ByteArray;
	import game.core.InputManager;
	import game.GameElements;
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	import game.scene.IScene;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.utils.Color;
	import utils.updates.update;
	
	use namespace update;
	
	public class MapFeature 
	{
		private const C_WIDTH:int = 2;
		private const BORDER_WIDTH:int = 40;
		
		private const NOT_VISITED:int = 0;
		private const VISITED:int = 1;
		
		private var visited:ByteArray;
		
		private var scene:IScene;
		private var center:ICoordinated;
		
		private var input:InputManager;
		
		private var container:QuadBatch;
		
		private var tiles:Array;
		
		private var minX:int;
		private var maxX:int = 0;
		private var minY:int;
		private var maxY:int = 0;
		
		public function MapFeature(elements:GameElements) 
		{
			this.visited = new ByteArray();
			
			this.scene = elements.scene;
			this.input = elements.input;
			
			this.tiles = new Array();
			this.tiles[Game.SCENE_LAVA] = new Quad(2, 2, 0xFF0000);
			this.tiles[Game.SCENE_FALL] = new Quad(2, 2, 0x000000);
			this.tiles[Game.SCENE_ROAD] = new Quad(2, 2, 0x8B4513);
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.restore);
			elements.flow.addUpdateListener(Update.setCenter);
			elements.flow.addUpdateListener(Update.toggleMap);
			elements.flow.addUpdateListener(Update.numberedFrame);
			elements.flow.addUpdateListener(Update.frameOfTheMapMode);
			elements.flow.addUpdateListener(Update.quitGame);
			
			this.container = new QuadBatch();
			elements.displayRoot.addChild(this.container);
		}
		
		update function restore(config:GameConfig):void
		{
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
		}
		
		update function setCenter(center:ICoordinated):void//TODO: use this update where it will be of use
		{
			this.center = center;
			
			this.container.reset();
		}
		
		update function toggleMap():void
		{
			this.container.visible = !this.container.visible;
			
			this.input.getInputCopy();//TODO: fix when syntax is revised
		}
		
		update function numberedFrame(key:int):void
		{
			if (key == Game.FRAME_TO_UNLOCK_ACHIEVEMENTS)
			{
				var iGoal:int = this.center.x + 8;
				var jGoal:int = this.center.y + 6;
				
				for (var i:int = this.center.x - 7; i < iGoal; i++)
					for (var j:int = this.center.y - 5; j < jGoal; j++)
					{
						if (this.visited[normalize(i) + Game.MAP_WIDTH * normalize(j)] == this.NOT_VISITED)
						{
							this.visited[normalize(i) + Game.MAP_WIDTH * normalize(j)] = this.VISITED;
							
							var quad:Quad = this.tiles[this.scene.getSceneCell(i, j)];
							
							quad.x = this.BORDER_WIDTH + this.C_WIDTH * normalize(i);
							quad.y = this.BORDER_WIDTH + this.C_WIDTH * normalize(j);
							
							this.container.addQuad(quad);
						}
					}
			}
		}
		
		update function frameOfTheMapMode():void
		{
			var input:Vector.<DCellXY> = this.input.getInputCopy();
			var action:DCellXY = input.pop();
			
			const STEP:int = 4;
			
			while (action && (action.x + action.y != 0))//implying it's 0 if both are 0
			{
				this.container.x -= STEP * action.x;
				this.container.y -= STEP * action.y;
				
				action = input.pop();
			}//TODO: something is wrong here, must investigate someday
			
			if (this.container.x < this.minX)
				this.container.x = this.minX;
			else if (this.container.x > this.maxX)
				this.container.x = this.maxX;
			
			if (this.container.y < this.minY)
				this.container.y = this.minY;
			else if (this.container.y > this.maxY)
				this.container.y = this.maxY;
		}
		
		update function quitGame():void
		{
			this.container.reset();
			
			this.visited.clear();
			
			this.container.visible = false;
		}
	}

}
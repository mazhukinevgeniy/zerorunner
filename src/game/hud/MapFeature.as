package game.hud 
{
	import data.viewers.GameConfig;
	import flash.utils.ByteArray;
	import game.core.InputManager;
	import game.GameElements;
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
		
		private const NOT_VISITED:int = 0;
		private const VISITED:int = 1;
		
		private var visited:ByteArray;
		
		private var scene:IScene;
		private var center:ICoordinated;
		
		private var input:InputManager;
		
		private var container:QuadBatch;
		
		private var road:Quad;
		
		private var minX:int;
		private var maxX:int = 0;
		private var minY:int;
		private var maxY:int = 0;
		
		public function MapFeature(elements:GameElements) 
		{
			this.visited = new ByteArray();
			
			this.scene = elements.scene;
			this.input = elements.input;
			
			this.road = new Quad(2, 2, 0x999900);
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.restore);
			elements.flow.addUpdateListener(Update.setCenter);
			elements.flow.addUpdateListener(Update.toggleMap);
			elements.flow.addUpdateListener(Update.numberedFrame);
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
			
			const BORDER_WIDTH:int = 40;
			
			var borderPiece:Quad = new Quad(BORDER_WIDTH, BORDER_WIDTH, Color.NAVY);
			
			const MAX_WIDTH:int = Game.MAP_WIDTH * this.C_WIDTH + 2 * BORDER_WIDTH;
			
			if ((Game.MAP_WIDTH * this.C_WIDTH) % BORDER_WIDTH != 0)
				throw new Error("can't render map borders");
			
			for (i = 0; i < MAX_WIDTH; i += BORDER_WIDTH)
			{
				borderPiece.y = 0;
				borderPiece.x = i;
				
				this.container.addQuad(borderPiece);
				
				borderPiece.y = MAX_WIDTH - BORDER_WIDTH;
				
				this.container.addQuad(borderPiece);
				
				borderPiece.x = 0;
				borderPiece.y = i;
				
				this.container.addQuad(borderPiece);
				
				borderPiece.x = MAX_WIDTH - BORDER_WIDTH;
				
				this.container.addQuad(borderPiece);
			}
			
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
							
							if (this.scene.getSceneCell(i, j) != Game.SCENE_FALL)
							{
								this.road.x = 2 * normalize(i);
								this.road.y = 2 * normalize(j);
								
								this.container.addQuad(this.road);
							}
						}
					}
			}
		}
		
		update function quitGame():void
		{
			this.container.reset();
			
			this.visited.clear();
			
			this.container.visible = false;
		}
	}

}
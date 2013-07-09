package chaotic.scene 
{
	import chaotic.choosenArea.ChoosenArea;
	import chaotic.choosenArea.ISector;
	import chaotic.informers.IGiveInformers;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.metric.DPixelXY;
	import chaotic.metric.Metric;
	import chaotic.metric.PixelXY;
	import chaotic.ui.Camera;
	import chaotic.updates.IUpdateDispatcher;
	import chaotic.updates.IUpdateListener;
	import chaotic.updates.IUpdateListenerAdder;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	internal class LandscapeCanvas implements IUpdateListener
	{
		private var assets:AssetManager;
		private var atlas:TextureAtlas;
		
		private var textures:Vector.<Texture>;
		
		private var lastAccessed:DrawingCell;
		
		private var topLeftX:int = 0;
		private var topLeftY:int = 0;
		
		private var container:Sprite;
		
		public function LandscapeCanvas() 
		{
			this.container = new Sprite();
			this.container.touchable = false;
		}
		
		public function addListenersTo(storage:IUpdateListenerAdder):void
		{
			storage.addUpdateListener(this, "prerestore");
			storage.addUpdateListener(this, "newTopLeftCell");
			storage.addUpdateListener(this, "addedScenePiece");
			storage.addUpdateListener(this, "movedTopLeftCell");
			storage.addUpdateListener(this, "getInformerFrom");
		}
		
		public function newTopLeftCell(cCell:CellXY):void
		{
			var cell:PixelXY = Metric.toPixel(cCell);
			
			this.topLeftX = cell.x;
			this.topLeftY = cell.y;
			
			for (var i:int = 0; i < ChoosenArea.SECTORS_IN_STABLE_WIDTH; i++)
			{
				for (var j:int = 0; j < ChoosenArea.SECTORS_IN_STABLE_HEIGHT; j++)
				{
					this.lastAccessed.x = cell.x + i * ChoosenArea.CELLS_IN_SECTOR_WIDTH * Metric.CELL_WIDTH;
					this.lastAccessed.y = cell.y + j * ChoosenArea.CELLS_IN_SECTOR_HEIGHT * Metric.CELL_HEIGHT;
					
					this.lastAccessed = this.lastAccessed.down;
				}
				
				this.lastAccessed = this.lastAccessed.right;
			}
		}
		
		public function movedTopLeftCell(cChange:DCellXY):void
		{
			var change:DPixelXY = Metric.toPixel(cChange);
			
			var i:int;
			
			var dX:int = sign(change.x);
			var dY:int = sign(change.y);
			
			this.returnToTopLeft();
			
			if (dX == -1)
			{
				this.lastAccessed = this.lastAccessed.left;
				
				for (i = 0; i < ChoosenArea.SECTORS_IN_STABLE_HEIGHT; i++)
				{
					this.lastAccessed.x = this.lastAccessed.right.x - ChoosenArea.CELLS_IN_SECTOR_WIDTH * Metric.CELL_WIDTH;
					
					this.lastAccessed = this.lastAccessed.down;
				}
				
				this.topLeftX -= ChoosenArea.CELLS_IN_SECTOR_WIDTH * Metric.CELL_WIDTH;
			}
			else if (dX == 1)
			{
				for (i = 0; i < ChoosenArea.SECTORS_IN_STABLE_HEIGHT; i++)
				{
					this.lastAccessed.x = this.lastAccessed.left.x + ChoosenArea.CELLS_IN_SECTOR_WIDTH * Metric.CELL_WIDTH;
					
					this.lastAccessed = this.lastAccessed.down;
				}
				
				this.topLeftX += ChoosenArea.CELLS_IN_SECTOR_WIDTH * Metric.CELL_WIDTH;
			}
			else if (dY == -1)
			{
				this.lastAccessed = this.lastAccessed.up;
				
				for (i = 0; i < ChoosenArea.SECTORS_IN_STABLE_WIDTH; i++)
				{
					this.lastAccessed.y = this.lastAccessed.down.y - ChoosenArea.CELLS_IN_SECTOR_HEIGHT * Metric.CELL_HEIGHT;
					
					this.lastAccessed = this.lastAccessed.right;
				}
				
				this.topLeftY -= ChoosenArea.CELLS_IN_SECTOR_HEIGHT * Metric.CELL_HEIGHT;
			}
			else if (dY == 1)
			{
				for (i = 0; i < ChoosenArea.SECTORS_IN_STABLE_WIDTH; i++)
				{
					this.lastAccessed.y = this.lastAccessed.up.y + ChoosenArea.CELLS_IN_SECTOR_HEIGHT * Metric.CELL_HEIGHT;
					
					this.lastAccessed = this.lastAccessed.right;
				}
				
				this.topLeftY += ChoosenArea.CELLS_IN_SECTOR_HEIGHT * Metric.CELL_HEIGHT;
			}
			
			function sign(num:Number):int
			{
				return (num > 0) ? 1 : ((num < 0) ? -1 : 0);
			}
		}
		
		public function addedScenePiece(sector:ISector):void
		{
			var pCell:PixelXY = Metric.toPixel(sector.topLeftCell);
			var x:int = pCell.x;
			var y:int = pCell.y;
			
			var sectorX:int = x;
			var sectorY:int = y;
			
			while (this.lastAccessed.x != sectorX)
			{
				this.lastAccessed = this.lastAccessed.right;
			}
			
			while (this.lastAccessed.y != sectorY)
			{
				this.lastAccessed = this.lastAccessed.down;
			}
			
			this.drawSector(sector, this.lastAccessed);
		}
		
		private function drawSector(sector:ISector, sprite:Sprite):void
		{
			sprite.removeChildren();
			
			var code:Vector.<int> = sector.getCode();
			
			for (var i:int = 0; i < ChoosenArea.CELLS_IN_SECTOR_WIDTH; i++)
				for (var j:int = 0; j < ChoosenArea.CELLS_IN_SECTOR_HEIGHT; j++)
				{
					var tmp:Image = new Image(this.textures[code[i + j * ChoosenArea.CELLS_IN_SECTOR_WIDTH]]);
					tmp.x = i * Metric.CELL_WIDTH;
					tmp.y = j * Metric.CELL_HEIGHT;
					sprite.addChild(tmp);
				}
		}
		
		private function returnToTopLeft():void
		{
			while (this.lastAccessed.x != this.topLeftX)
				this.lastAccessed = this.lastAccessed.right;
			while (this.lastAccessed.y != this.topLeftY)
				this.lastAccessed = this.lastAccessed.down;
		}
		
		
		public function prerestore():void
		{
			this.container.removeChildren();
			
			var tmpArrays:Array = new Array(ChoosenArea.SECTORS_IN_STABLE_HEIGHT);
			
			for (var i:int = 0; i < ChoosenArea.SECTORS_IN_STABLE_HEIGHT; i++)
			{
				tmpArrays[i] = new Array(ChoosenArea.SECTORS_IN_STABLE_WIDTH);
				
				for (var j:int = 0; j < ChoosenArea.SECTORS_IN_STABLE_WIDTH; j++)
				{
					this.container.addChild(tmpArrays[i][j] = new DrawingCell());
				}
				
				for (j = 0; j < ChoosenArea.SECTORS_IN_STABLE_WIDTH - 1; j++)
				{
					tmpArrays[i][j].right = tmpArrays[i][j+1];
					tmpArrays[i][j+1].left = tmpArrays[i][j];
				}
				
				tmpArrays[i][0].left = tmpArrays[i][ChoosenArea.SECTORS_IN_STABLE_WIDTH - 1];
				tmpArrays[i][ChoosenArea.SECTORS_IN_STABLE_WIDTH - 1].right = tmpArrays[i][0];
			}
			
			for (i = 0; i < ChoosenArea.SECTORS_IN_STABLE_HEIGHT - 1; i++)
			{
				for (j = 0; j < ChoosenArea.SECTORS_IN_STABLE_WIDTH; j++)
				{
					tmpArrays[i][j].down = tmpArrays[i+1][j];
					tmpArrays[i+1][j].up = tmpArrays[i][j];
				}
			}
			
			for (j = 0; j < ChoosenArea.SECTORS_IN_STABLE_WIDTH; j++)
			{
				tmpArrays[0][j].up = tmpArrays[ChoosenArea.SECTORS_IN_STABLE_HEIGHT - 1][j];
				tmpArrays[ChoosenArea.SECTORS_IN_STABLE_HEIGHT - 1][j].down = tmpArrays[0][j];
			}
			
			this.lastAccessed = tmpArrays[0][0];
			
			
			this.atlas = this.assets.getTextureAtlas("gameAtlas");
			this.textures = new Vector.<Texture>(2, true);
			this.textures[1] = atlas.getTexture("scene" + 0);
			this.textures[0] = atlas.getTexture("scene" + 1);
		}
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			table.getInformer(IUpdateDispatcher).dispatchUpdate("addToTheLayer", Camera.SCENE, this.container);
			
			this.assets = table.getInformer(AssetManager);
		}
	}

}
package game.scene 
{
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.time.ICacher;
	
	internal class LandscapeCache implements ICacher
	{
		private var cacheVector:Vector.<int>;
		
		private const width:int = 2 * (6 * int(Metric.CELLS_IN_VISIBLE_WIDTH / 6) + 6);
		private const widthDivBy6:int = 2 * (int(Metric.CELLS_IN_VISIBLE_WIDTH / 6) + 1);
		private const height:int = 2 * (6 * int(Metric.CELLS_IN_VISIBLE_HEIGHT / 6) + 6);
		
		private var part:int = 0;
		
		private var tLC:CellXY;
		
		private var nextY:DCellXY = new DCellXY(0, 1);
		private var nextColumn:DCellXY;
		
		private var scene:Scene;
		
		public function LandscapeCache(scene:Scene) 
		{
			this.scene = scene;
			
			this.nextColumn = new DCellXY(1, -this.height);
		
			
			this.cacheVector = new Vector.<int>(this.width * this.height, true);
			
			this.tLC = new CellXY(40 - 10, 40 - 10); //why so?
		}
		
		internal function setTopLeftCell(cell:CellXY):void
		{
			this.tLC = new CellXY(cell.x - 3, cell.y - 3); // TODO: why so?
		}
		
		internal function isCached(x:int, y:int):Boolean
		{
			return false;//TODO: implementx - c
		}
		
		internal function getCached(x:int, y:int):int
		{
			x -= this.tLC.x;
			y -= this.tLC.y;
			
			return this.cacheVector[x + y * this.width];
		}
		
		public function cache():void
		{
			var cell:CellXY = this.tLC.getCopy().applyChanges(new DCellXY(this.part * this.widthDivBy6, 0));
			
			var xGoal:int = this.widthDivBy6 * (this.part + 1);
			
			for (var i:int = this.widthDivBy6 * this.part; i < xGoal; i++)
			{
				trace(cell.x, cell.y);
				for (var j:int = 0; j < this.height; j++)
				{
					this.cacheVector[i + j * this.width] = this.scene.getSceneCell(cell);
					
					cell.applyChanges(this.nextY);
				}
				
				cell.applyChanges(this.nextColumn);
			}
			
			this.part++;
			this.part %= 6;
		}
	}

}
package chaotic.choosenArea 
{
	import chaotic.actors.ActorsFeature;
	import chaotic.informers.IGiveInformers;
	import chaotic.informers.IStoreInformers;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.metric.Metric;
	import chaotic.scene.IScene;
	import chaotic.scene.SceneFeature;
	import chaotic.updates.ICenterDependant;
	import chaotic.updates.IInformerAdder;
	import chaotic.updates.IInformerGetter;
	import chaotic.updates.IPrerestorable;
	import chaotic.updates.IUpdateDispatcher;
	import chaotic.updates.Update;
	
	public class ChoosenArea implements IPrerestorable, ICenterDependant, IInformerGetter, IInformerAdder, IChoosenArea
	{
		public static const CELLS_IN_SECTOR_HEIGHT:int = 9;
		public static const CELLS_IN_SECTOR_WIDTH:int = 9;
		
		public static const SECTORS_IN_STABLE_HEIGHT:int = 5;
		public static const SECTORS_IN_STABLE_WIDTH:int = 5;
		
		public static const CELLS_IN_STABLE_HEIGHT:int = ChoosenArea.SECTORS_IN_STABLE_HEIGHT * ChoosenArea.CELLS_IN_SECTOR_HEIGHT;
		public static const CELLS_IN_STABLE_WIDTH:int = ChoosenArea.SECTORS_IN_STABLE_WIDTH * ChoosenArea.CELLS_IN_SECTOR_WIDTH;
		
		private var topLeftCell:CellXY;
		private var centerCell:CellXY;
		
		private var scene:IScene;
		
		private var updateFlow:IUpdateDispatcher;
		
		public function ChoosenArea() 
		{
			
		}
		
		public function prerestore():void
		{
			this.centerCell = ActorsFeature.SPAWN_CELL;
			this.topLeftCell = new CellXY(this.centerCell.x - (ChoosenArea.CELLS_IN_STABLE_WIDTH - 1) / 2,
										  this.centerCell.y - (ChoosenArea.CELLS_IN_STABLE_HEIGHT - 1) / 2);
		}
		
		public function isInArea(x:int, y:int):Boolean
		{
			return (x >= this.topLeftCell.x) && (x <= this.topLeftCell.x + ChoosenArea.CELLS_IN_STABLE_WIDTH) &&
			       (y >= this.topLeftCell.y) && (y <= this.topLeftCell.y + ChoosenArea.CELLS_IN_STABLE_HEIGHT);
		}
		
		public function setCenter(cell:CellXY):void
		{
			this.centerCell = cell.getCopy();
			
			this.topLeftCell = new CellXY(cell.x - (ChoosenArea.CELLS_IN_STABLE_WIDTH - 1) / 2,
										  cell.y - (ChoosenArea.CELLS_IN_STABLE_HEIGHT - 1) / 2);
			
			this.updateFlow.dispatchUpdate(new Update("newTopLeftCell", this.topLeftCell));
			
			for (var i:int = 0; i < ChoosenArea.SECTORS_IN_STABLE_WIDTH; i++)
				for (var j:int = 0; j < ChoosenArea.SECTORS_IN_STABLE_HEIGHT; j++)
					this.updateFlow.dispatchUpdate(new Update("addedScenePiece", 
						this.composeSector(new CellXY(this.topLeftCell.x + i * ChoosenArea.CELLS_IN_SECTOR_WIDTH,
													  this.topLeftCell.y + j * ChoosenArea.CELLS_IN_SECTOR_HEIGHT))));
		}
		
		public function moveCenter(change:DCellXY, ticksToGo:int = 0):void
		{
			this.centerCell.applyChanges(change);
			
			while (this.centerCell.x - (Metric.CELLS_IN_VISIBLE_WIDTH - 1) / 2 < this.topLeftCell.x)
				this.moveSectors(new DCellXY( -ChoosenArea.CELLS_IN_SECTOR_WIDTH, 0));
			while (this.centerCell.x + (Metric.CELLS_IN_VISIBLE_WIDTH - 1) / 2 >= this.topLeftCell.x + ChoosenArea.CELLS_IN_STABLE_WIDTH - 1)
				this.moveSectors(new DCellXY(ChoosenArea.CELLS_IN_SECTOR_WIDTH, 0));
			while (this.centerCell.y - (Metric.CELLS_IN_VISIBLE_HEIGHT - 1) / 2 < this.topLeftCell.y)
				this.moveSectors(new DCellXY(0, -ChoosenArea.CELLS_IN_SECTOR_HEIGHT));
			while (this.centerCell.y + (Metric.CELLS_IN_VISIBLE_HEIGHT - 1) / 2 >= this.topLeftCell.y + ChoosenArea.CELLS_IN_STABLE_HEIGHT - 1)
				this.moveSectors(new DCellXY(0, ChoosenArea.CELLS_IN_SECTOR_HEIGHT));
		}
		
		private function moveSectors(change:DCellXY):void
		{
			var i:int, j:int;
			
			var vertical:Boolean = (change.x == 0);
			
			this.topLeftCell.applyChanges(change);
			
			this.updateFlow.dispatchUpdate(new Update("movedTopLeftCell", change));
			
			var a:int = int(change.x == ChoosenArea.CELLS_IN_SECTOR_WIDTH);
			var b:int = int(change.y == ChoosenArea.CELLS_IN_SECTOR_HEIGHT);
			
			for (i = 0; vertical && (i < ChoosenArea.SECTORS_IN_STABLE_WIDTH) || !vertical && (i < 1); i++)
				for (j = 0; vertical && (j < 1) || !vertical && (j < ChoosenArea.SECTORS_IN_STABLE_HEIGHT); j++)
					this.updateFlow.dispatchUpdate(new Update("addedScenePiece", 
						this.composeSector(new CellXY(
							this.topLeftCell.x + i * ChoosenArea.CELLS_IN_SECTOR_WIDTH + a * (ChoosenArea.CELLS_IN_STABLE_WIDTH - ChoosenArea.CELLS_IN_SECTOR_WIDTH),
							this.topLeftCell.y + j * ChoosenArea.CELLS_IN_SECTOR_HEIGHT + b * (ChoosenArea.CELLS_IN_STABLE_HEIGHT - ChoosenArea.CELLS_IN_SECTOR_HEIGHT)))));
		}
		
		private function composeSector(cell:CellXY):Sector
		{
			var tmp:Vector.<int> = new Vector.<int>(ChoosenArea.CELLS_IN_SECTOR_HEIGHT * ChoosenArea.CELLS_IN_SECTOR_WIDTH, true);
			
			for (var i:int = 0; i < ChoosenArea.CELLS_IN_SECTOR_WIDTH; i++)
				for (var j:int = 0; j < ChoosenArea.CELLS_IN_SECTOR_HEIGHT; j++)
					tmp[i + j * ChoosenArea.CELLS_IN_SECTOR_WIDTH] = this.getSpriteCode(new CellXY(cell.x + i, cell.y + j));
			return new Sector(cell, tmp);
		}
		
		private function getSpriteCode(cell:CellXY):int
		{
			var tmp:int = this.scene.getSceneCell(cell);
			
			if (tmp == SceneFeature.ROAD)
				return SceneFeature.DRAWING_ROAD;
			else
				return SceneFeature.DRAWING_FALL;
		}
		
		
		public function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(IChoosenArea, this);
		}
		public function getInformerFrom(table:IGiveInformers):void
		{
			this.scene = table.getInformer(IScene);
			this.updateFlow = table.getInformer(IUpdateDispatcher);
		}
	}

}
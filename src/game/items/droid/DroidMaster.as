package game.items.droid 
{
	import data.viewers.GameConfig;
	import game.core.metric.CellXY;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.GameElements;
	import game.items.MasterBase;
	import utils.updates.update;
	
	public class DroidMaster extends MasterBase
	{
		private var elements:GameElements;
		
		public function DroidMaster(elements:GameElements) 
		{
			this.elements = elements;
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
			elements.flow.addUpdateListener(Update.droidUnlocked);
		}
		
		update function prerestore(config:GameConfig):void
		{
			var i:int;
			
			for (i = 0; i < config.numberOfDroids; i++)
			{
				var center:ICoordinated = this.elements.pointsOfInterest.getCharacter();
				
				var tmpCell:CellXY = new CellXY(center.x - 4, center.y + 4);
				
				while (this.elements.items.findObjectByCell(tmpCell.x, tmpCell.y))
					tmpCell.setValue(tmpCell.x, tmpCell.y - 1);
				
				new Droid(this, this.elements, tmpCell);
			}
		}
		
		update function droidUnlocked(place:CellXY):void
		{
			new Droid(this, this.elements, place);
		}
		
		/*
			if (key == Game.UNUSED_FRAME_1) //right before you act
			{
				var pos:ICoordinated = this.character;
			
				for (var i:int = -5; i < 6; i++)
					for (var j:int = -5; j < 6; j++)
					{
						var item:ItemBase = this.items.findObjectByCell(pos.x + i, pos.y + j);
						
						if (item && item.contraption && !item.contraption.finished)
							this.points.addPointOfInterest(Game.TOWER, item.existence);
					}
			}*/
		//TODO: enable droids as soon as you have an idea about how they choose a target
		//it's a valid hostility scale: friendly, contraption, hostile. huh?
	}

}
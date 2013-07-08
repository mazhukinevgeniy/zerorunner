package chaotic.actors.manipulator.onBlocked 
{
	import chaotic.actors.manipulator.ActionBase;
	import chaotic.actors.storage.Puppet;
	import chaotic.actors.storage.ISearcher;
	import chaotic.metric.CellXY;
	
	internal class AOEActionBase extends ActionBase
	{
		protected var searcher:ISearcher;
		
		public function AOEActionBase() 
		{
			
		}
		
		protected function getTargetsInSquare(tlX:int, tlY:int, width:int):Vector.<Puppet>
		{
			var toReturn:Vector.<Puppet> = new Vector.<Puppet>();
			
			var maxX:int = tlX + width;
			var maxY:int = tlY + width;
			
			for (var i:int = tlX; i < maxX; i++)
				for (var j:int = tlY; j < maxY; j++)
					if ((i != tlX + (width - 1) / 2) || (j != tlY + (width - 1) / 2))
					{
						var item:Puppet = this.searcher.findObjectByCell(new CellXY(i, j));
						
						if (item != null) toReturn.push(item);
					}
			
			return toReturn;
		}
	}

}
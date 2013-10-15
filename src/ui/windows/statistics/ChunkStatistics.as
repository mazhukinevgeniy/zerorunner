package ui.windows.statistics 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import ui.themes.ExtendedTheme;
	
	internal class ChunkStatistics extends ScrollContainer
	{
		public static const CHUNK_STATISTICS_DRAG_FORMAT:String = "chunk-statistics-drag-format"
		
		private static const GAP:Number = 3;
		private static const BUTTON_PADDING_TOP:Number = 5;
		
		private var list:List;
		private var label:Label;
		
		private var fullHeight:Number;
		
		
		public function ChunkStatistics(name:String, newValue:int) 
		{
			this.initializeTitle(name);
			this.initializeList(newValue);//TODO: what value?
			
			this.layout = new AnchorLayout();
			
			//TODO: absorb constructing functions
		}

		private function makeListInvisible():void
		{
			this.list.visible = false;
			this.fullHeight = this.height;
		}
		
		private function makeListVisible():void
		{
			this.list.visible = true;
			this.height = this.fullHeight;
		}
		
		private function initializeTitle(newTitle:String):void
		{
			this.label = new Label();
			this.label.text = newTitle;
			this.label.nameList.add(ExtendedTheme.TITLE_STATICTICS_PIECE);
			this.label.layoutData = this.createLayoutData(null, 0, this.fixButton, ChunkStatistics.GAP)
			this.addChild(this.label);
		}
		
		private function initializeList(value:int):void
		{
			this.list = writeInList(value);
			this.list.width = StatisticsWindow.WIDTH_STATISTICS_WINDOW;
			this.list.layoutData = this.createLayoutData(this.label, ChunkStatistics.GAP);
			this.addChild(this.list);
		}
		
		private function writeInList(value:int):List
		{
			var list:List = new List();
			var data:Vector.<Object> = new Vector.<Object>;
			
			list.dataProvider = new ListCollection(data);
			
			var string:int = value;
			data.push(string);
			
			return list;
		}
		
		private function createLayoutData(topAnchor:DisplayObject = null, top:Number = 0,
										  leftAnchor:DisplayObject = null, left:Number = 0):AnchorLayoutData
		{
			var layoutData:AnchorLayoutData = new AnchorLayoutData();
			
			if(leftAnchor != null)
				layoutData.leftAnchorDisplayObject = leftAnchor;
			
			if (topAnchor != null)
				layoutData.topAnchorDisplayObject = topAnchor;
			
			layoutData.left = left;
			layoutData.top = top;
			
			return layoutData;
		}
		public function get title():String
		{
			return this.label.text;
		}
		
		public function updateData(value:int):void
		{
			var newList:List = this.writeInList(value);
			this.list.dataProvider = newList.dataProvider;
		}
		
	}

}
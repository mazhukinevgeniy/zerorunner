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
	import ui.windows.Window;
	
	internal class ChunkStatistics extends ScrollContainer
	{
		
		private static const GAP:Number = 3;
		private static const BUTTON_PADDING_TOP:Number = 5;
		
		private var list:List;
		private var label:Label;
		
		private var fullHeight:Number;
		
		
		public function ChunkStatistics(title:String, data:Vector.<String>) 
		{
			super();
			
			this.setTitle(title);
			this.initializeList(data);
			
			this.layout = new AnchorLayout();
		}
		
		private function setTitle(title:String):void
		{
			this.label = new Label();
			this.label.text = title;
			this.label.nameList.add(ExtendedTheme.TITLE_STATICTICS_PIECE);
			this.addChild(this.label);
		}
		
		private function initializeList(data:Vector.<String>):void
		{
			this.list = new List();
			
			this.list.dataProvider = new ListCollection(data);
			
			this.list.width = Window.WIDTH;
			this.list.layoutData = createLayoutData(this.label, ChunkStatistics.GAP);
			this.addChild(this.list);
			
			
			function createLayoutData(topAnchor:DisplayObject = null, top:Number = 0,
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
		}
	}

}
package model 
{
	import game.interfaces.IRestorable;
	
	public class Restorer 
	{
		private var subscribers:Vector.<IRestorable>;
		
		public function Restorer() 
		{
			
			this.subscribers = new Vector.<IRestorable>();
		}
		
		public function addSubscriber(item:IRestorable):void
		{
			this.subscribers.push(item);
		}
		
		
		internal function triggerRestore():void
		{
			for (var i:int = 0; i < this.subscribers.length; i++)
				this.subscribers[i].restore();
		}
	}

}
package view 
{
		private function initializeFeatures(elements:GameElements):void
		{
			new Theme(elements, this.ownRoot);
			
			this.background = new Background();
			
			
			
			this.navigation = new Navigation(elements);
			this.windows = new Windows(elements)
			
			new Sounds(elements);
			
			this.ownRoot.addChild(this.background);
			this.ownRoot.addChild(this.windows);
			this.ownRoot.addChild(this.navigation);
		}
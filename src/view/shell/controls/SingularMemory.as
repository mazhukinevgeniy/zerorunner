package view.shell.controls 
{
	import feathers.core.FeathersControl;
	import view.themes.ShellTheme;
	
	public class SingularMemory extends FeathersControl
	{
		private var _type:int;
		
		public function SingularMemory(type:int, isUnlocked:Boolean) 
		{
			super();
			
			this._type = type;
			
			this.nameList.add(
				isUnlocked ? ShellTheme.MEMORY_UNLOCKED : ShellTheme.MEMORY_LOCKED);
		}
		
		public function get type():int
		{
			return _type;
		}
	}

}
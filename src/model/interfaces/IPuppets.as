package model.interfaces 
{
	import model.items.PuppetBase;
	
	public interface IPuppets 
	{
		function findAnyObjectByCell(x:int, y:int):PuppetBase;
	}
	
}
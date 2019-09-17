package
{
	//import flash.ui.Mouse;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**/
	
	
	[SWF(width="640",height="480")]
	
	public class Main extends Engine
	{
		
		public function Main():void
		{
			super(640,480, 60, false);
			FP.screen.color = 0x000000;	
			FP.world = new GameWorld();
		}
	
	}

}
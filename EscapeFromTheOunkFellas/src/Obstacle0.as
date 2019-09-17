package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * ...
	 * @author Juan
	 */
	public class Obstacle0 extends Entity
	{
		[Embed(source = "obstacle0.png")] private const OBS0:Class;
		private var obs0:Image;
		public function Obstacle0(px:Number = 0,py:Number=0) 
		{
			obs0 = new Image( OBS0);
			super(px, py,obs0);
			mask = new Pixelmask( OBS0);
			type = "Obstacle0";
		}
		override public function update():void
		{
			var collidable:Entity = this.collide("Player", this.x, this.y);
			if (collidable)
			{
				var tempPlayer:Player = collidable as Player;
				tempPlayer.die();	
			}
			super.update();
		}
	}
}
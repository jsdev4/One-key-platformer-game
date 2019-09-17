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
	public class Level0 extends Entity
	{
		[Embed(source = "level0.png")] private const LEVEL0:Class;
		private var level0:Image;
		public function Level0(px:Number = 0,py:Number=0) 
		{
			level0 = new Image( LEVEL0);
			super(px, py,level0);
			mask = new Pixelmask( LEVEL0);
			type = "Level0";
		}
		override public function update():void
		{
			var collidable:Entity = this.collide("Player", this.x, this.y);
			if (collidable)
			{
				var tempPlayer:Player = collidable as Player;
				tempPlayer.y = this.y -66;
			}
			super.update();
		}
	}
}
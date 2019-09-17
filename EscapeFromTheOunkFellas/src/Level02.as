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
	public class Level02 extends Entity
	{
		[Embed(source = "level02.png")] private const LEVEL02:Class;
		private var level02:Image;
		public function Level02(px:Number = 0,py:Number=0) 
		{
			level02 = new Image( LEVEL02);
			super(px, py,level02);
			mask = new Pixelmask( LEVEL02);
			type = "Level02";
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
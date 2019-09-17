package 
{
	import flash.events.AsyncErrorEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	public class Player extends Entity
	{
		[Embed(source = "rabbit_standby.png")]
		private const PLAYER:Class;
		private var player:Image;
		[Embed(source = "rabbit_fixed.png")]
		private const PLAYER_ANIM:Class;
		private var player_anim:Spritemap;
		[Embed(source="26 Count Down.mp3")]
		private const LOSESOUND:Class;
		private var lose_sound:Sfx;
		[Embed(source = "mk2-00190.mp3")]
		private const JUMP:Class;
		private var jump:Sfx;
		private var gravity:Number;
		private var time_to_run:Number;
		private var to_flip:Boolean;
		public var is_running:Boolean;
		private var floor:int;
		public var can_jump:Boolean;
		private var loseText:Text;
		private var game_over:Boolean;
		public function Player(px:Number = 0, py:Number = 0) 
		{
			time_to_run = 0;
			gravity = 9.81;
			floor = 0;
			player = new Image(PLAYER);
			player_anim = new Spritemap(PLAYER_ANIM,58,70);
			player_anim.add("standby", [0], 30, false);
			player_anim.add("running", [ 1 , 2, 3], 10, true);
			player_anim.add("fall", [4, 5], 30, false);
			to_flip = false;
			is_running = false;
			can_jump = false;
			super(px, py, player_anim);
			mask = new Pixelmask(PLAYER);
			type = "Player";
			game_over = false;
			lose_sound = new Sfx(LOSESOUND);
			jump = new Sfx(JUMP);
		}
		override public function update():void
		{
			time_to_run += FP.elapsed;
			y += gravity * FP.elapsed;	
			if (time_to_run<= 8)
			{
				player_anim.play("standby");
				if (time_to_run <= 5)
				{
					player_anim.flipped = false;
				}
				if (time_to_run >= 6)
				{
					player_anim.flipped = true;
				}
				if (time_to_run >= 7)
				{
					player_anim.flipped = false;
				}
			}
			if (time_to_run >= 7)
			{
				if (Input.check(Key.SPACE))
				{
					is_running = true;	
				}
			}
			if (time_to_run >= 9)
			{
				can_jump = true;
			}
				if (can_jump == true&&time_to_run>=8)
				{
					if (Input.check(Key.SPACE))
					{
						jump.play();
						if (to_flip == false)
						{
							y -= 3000 * FP.elapsed;
							y += gravity * FP.elapsed;
							x +=1000 * FP.elapsed;
						}
						if (to_flip == true)
						{
							y -= 3000 * FP.elapsed;
							y += gravity * FP.elapsed;
							x -= 1000 * FP.elapsed;
						}
					}
				}                                                                   
				if (is_running == true)
				{
					player_anim.flipped = false;
					player_anim.play("running");
					
					if (to_flip==false)					
					{
						x += 100 * FP.elapsed;
						if ((this.x + this.getWidth()) >= FP.screen.width-5)					
						{
							to_flip = true;
							floor++;
						}	
					}
					if (to_flip == true)
					{
						player_anim.flipped = true;
						x -= 100 * FP.elapsed;
						if (this.x<= FP.screen.x-this.width )
						{
							to_flip = false;
							floor++;
						}
					}	
				}
				if (floor ==2&&this.x+this.getWidth()>=FP.screen.width-10)
				{
					is_running = false;
				}
				if (is_running == false)
				{
					x += 0 * FP.elapsed;
				}	
				if (player_anim.currentAnim == "fall" && player_anim.complete)
				{
					loseText = new Text("You failed to escape! Press SPACE");
					loseText.x = (FP.screen.width / 2);
					loseText.y = (FP.screen.height - 20);
					FP.world.addGraphic(loseText);
					lose_sound.play();
					game_over = true;			
				}
				if (game_over == true)
				{
					if (Input.check(Key.SPACE))
					{
						FP.world = new GameWorld();
					}
				}
			super.update();
		}
		
		public function getWidth():Number
		{
			return (player_anim.width / player_anim.columns);
		}
		public function getHeight():Number
		{
			return (player_anim.height / player_anim.rows);
		}
		public function getFloor():int
		{
			return floor;
		}
		public function die():void
		{//
			is_running = false;
			player_anim.play("fall");
		}
		public function getX():Number
		{
			return x;
		}
		public function animation_status():void
		{
			player_anim.play("standby");
		}
		public function get_gameOver():Boolean
		{
			return game_over;
		}
	}
}
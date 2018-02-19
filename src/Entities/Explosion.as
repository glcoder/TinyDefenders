package Entities 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	/**
	 * Simple explosion
	 * 
	 * @author Artem Gurevich / RadicalEd
	 */
	public class Explosion extends FlxSprite {
		private var counter:uint;
		
		public function Explosion(X:Number, Y:Number) {
			super(X, Y);
			loadGraphic(Assets.EXPLOSION, true, false, 16, 16);
			
			x -= width * 0.5;
			y -= height * 0.5;
			
			addAnimation("boom", [0, 1, 2, 3], 16, false);
			play("boom");
			
			addAnimationCallback(animationCallback);
			
			counter = 0;
			
			FlxG.play(Assets.SFX_EXPLOSION, 0.3);
		}
		
		private function animationCallback(name:String, frameNumber:uint, frameIndex:uint):void {
			if (!(FlxG.state is GameState))
				return;
			
			var gameState:GameState = FlxG.state as GameState;
			
			if (frameIndex > 2)
				++counter;
			
			if (counter > 1) {
				kill();
				gameState.effects.remove(this);
			}
		}
	}
}

package com.teamsketchy.util {
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	public class Cloak extends Bitmap {
		private var sprite:Sprite;
		
		public static function create(width:uint, height:uint, sprite:Sprite, keepSprite:Boolean = true):Cloak {
			var data:BitmapData = Cloak.dataFromSprite(width, height, sprite);
			var cloak:Cloak = new Cloak(data);
			
			if(keepSprite) cloak.sprite = sprite;
			
			return cloak;
		}
		public static function sew(width:uint, height:uint, instructions:Function, keepSprite:Boolean = true):Cloak {
			return Cloak.create(width, height, Cloak.spriteFromInstructions(instructions), keepSprite);
		}
		
		public function Cloak(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false) {
			super(bitmapData, pixelSnapping, smoothing);
		}
		public function recreate(width:uint, height:uint, sprite:Sprite = null, keepSprite:Boolean = true):void {
			if(sprite != null) {
				if(keepSprite) this.sprite = sprite;
				
				bitmapData = Cloak.dataFromSprite(width, height, sprite);
			} else if(this.sprite != null) {
				bitmapData = Cloak.dataFromSprite(width, height, this.sprite);
			} else {
				throw("Cached sprite or sprite parameter must not be null.");
			}
		}
		public function resew(width:uint, height:uint, instructions:Function, keepSprite:Boolean = true):void {
			recreate(width, height, Cloak.spriteFromInstructions(instructions), keepSprite);
		}
		
		private static function spriteFromInstructions(instructions:Function):Sprite {
			var sprite:Sprite = new Sprite();
			instructions(sprite);
			
			return sprite;
		}
		private static function dataFromSprite(width:uint, height:uint, sprite:Sprite):BitmapData {
			var data:BitmapData = new BitmapData(width, height, true, 0x0);
			data.draw(sprite);
			
			return data;
		}
	}
}
package Assets
{
	import flash.display.Bitmap;

	public class AssetManager
	{
		[Embed(source="../media/graphics/Skull.png")]
		public static const Skull:Class;
		
		[Embed(source="../media/graphics/tile.png")]
		public static const Tile:Class;
		
		[Embed(source="../media/graphics/revealedtile.png")]
		public static const RevealedTile:Class;
		
		private static var _instance:AssetManager;
		public function AssetManager()
		{
			
		}
		
		
		public static function getBitmap(name:String):Bitmap
		{
			return new AssetManager[name]();
		}
		
		
		public static function i():AssetManager
		{
			if(_instance == null){
				_instance = new AssetManager()
			}
			return _instance;
		}
		/*private static var gameTextures:Dictionary = new Dictionary();
		public static function getTexture(name:String):Texture
		{
			if(gameTextures[name]== undefined)
			{
				
				var bitmap:Bitmap = new AssetManager[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
				
			}
			return gameTextures[name];
		}*/
	}
}
package com.denis.at {
	import mx.resources.ResourceManager;

	public class LocaleSetter {
		public static function setCurrentLocale(locale:String):void {
			if (getCurrentLocale() == locale) {
				return;
			}
			if (isLocaleExist(locale)) {
				ResourceManager.getInstance().localeChain = [locale];
			}
		}

		public static function getCurrentLocale():String {
			return ResourceManager.getInstance().localeChain[0];
		}

		private static function isLocaleExist(locale:String):Boolean {
			var existLocales:Array /* of String */ = ResourceManager.getInstance().getPreferredLocaleChain();
			if (existLocales.indexOf(locale) >= 0) {
				return true;
			}
			return false;
		}
	}
}

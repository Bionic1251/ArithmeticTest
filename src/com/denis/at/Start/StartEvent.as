package com.denis.at.Start {
	import flash.events.Event;

	public class StartEvent extends Event {

		public static const START:String = "start";

		public function StartEvent(type:String) {
			super(type, true, false);
		}

		override public function clone():Event {
			return new StartEvent(type);
		}
	}
}
package com.denis.at.Game {
	import flash.events.Event;

	public class AnswerEvent extends Event {
		public static const ANSWERED:String = "answered";
		private var _answer:String;

		public function get answer():String {
			return _answer;
		}

		public function AnswerEvent(type:String, answer:String) {
			super(type, true);
			_answer = answer;
		}

		override public function clone():Event {
			return new AnswerEvent(type, _answer);
		}
	}
}
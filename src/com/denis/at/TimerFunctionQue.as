package com.denis.at {
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class TimerFunctionQue {
		private var timer:Timer;

		private var que:Array = new Array();

		public function TimerFunctionQue() {
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, tic);
			timer.start();
		}

		public function addFunction(vkFunction:VKFunction):void {
			que.push(vkFunction);
		}

		private function tic(event:TimerEvent):void {
			if (que.length > 0) {
				var vkFunction:VKFunction = que.pop();
				if (vkFunction.param2 == null) {
					vkFunction.vkfunction(vkFunction.param1);
				} else {
					vkFunction.vkfunction(vkFunction.param1, vkFunction.param2);
				}
			}
		}
	}
}

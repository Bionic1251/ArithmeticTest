package com.denis.at {
	import com.denis.at.vkTest.vk.APIConnection;

	import mx.controls.Alert;
	import mx.core.FlexGlobals;

	public class VKCommunicator {
		private var VK:APIConnection;

		private const USER_BEST_RESULT_VAR_NAME:String = "userBestResult";
		private const APP_BEST_RESULT_VAR_NAME:String = "appBestResult";
		private const BEST_USER_ID_VAR_NAME:String = "bestUserId";

		private var bestUserCallBackFunction:Function;

		public function VKCommunicator(flashVars:Object) {
			VK = new APIConnection(flashVars);
		}

		private function errorHandler(data:Object):void {
			Alert.show("Error is " + data.error_msg);
		}

		public function getUserBestResult(callBackFunction:Function):void {
			VK.api("storage.get", {key: USER_BEST_RESULT_VAR_NAME},
					callBackFunction, errorHandler);
		}

		public function setUserBestResult(callBackFunction:Function,
				data:String):void {
			VK.api("storage.set", {key: USER_BEST_RESULT_VAR_NAME, value: data},
					callBackFunction, errorHandler);
		}

		public function getAppBestResult(callBackFunction:Function):void {
			VK.api("storage.get", {key: APP_BEST_RESULT_VAR_NAME, global: 1},
					callBackFunction, errorHandler);
		}

		public function setAppBestResult(callBackFunction:Function,
				data:String):void {
			VK.api("storage.set",
					{key: APP_BEST_RESULT_VAR_NAME, global: 1, value: data},
					callBackFunction, errorHandler);
		}

		public function setBestUserId(callBackFunction:Function):void {
			var userId:String = String(FlexGlobals.topLevelApplication.parameters.viewer_id);
			VK.api("storage.set",
					{key: BEST_USER_ID_VAR_NAME, global: 1, value: userId},
					callBackFunction, errorHandler);
		}

		public function clearBestUserId(callBackFunction:Function):void {
			VK.api("storage.set",
					{key: BEST_USER_ID_VAR_NAME, global: 1, value: 0},
					callBackFunction, errorHandler);
		}

		public function getBestUser(callBackFunction:Function):void {
			bestUserCallBackFunction = callBackFunction;
			VK.api("storage.get",
					{key: BEST_USER_ID_VAR_NAME, global: 1},
					getBestUserHandler, errorHandler);
		}

		private function getBestUserHandler(data:Object):void {
			var userId:String = String(data);
			if(userId == "0") {
				bestUserCallBackFunction(null);
			}
			VK.api("users.get", {uids: userId},
					getUser, errorHandler);
		}

		private function getUser(data:Object):void {
			var tmpUser:Object = data[0];
			var user:User = new User();
			user.uid = tmpUser.uid;
			user.firstName = tmpUser.first_name;
			user.lastName = tmpUser.last_name;
			bestUserCallBackFunction(user);
		}
	}
}

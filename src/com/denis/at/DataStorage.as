package com.denis.at {
	[Bindable]
	public class DataStorage {
		public var userRightAnswerCount:int;
		public var userQuestionCount:int;

		public var appRightAnswerCount:int;
		public var appQuestionCount:int;

		public var bestUser:User;

		public var questionCount:int;
		public var rightAnswerCount:int;

		public var userBestResultCome:Boolean = false;
		public var appBestResultCome:Boolean = false;
		public var userCome:Boolean = false;

		public var userBestResultIsSet:Boolean = false;
		public var appBestResultIsSet:Boolean = false;
		public var userIsSet:Boolean = false;

		private var vkCommunicator:VKCommunicator;

		private var timerFunctionQue:TimerFunctionQue = new TimerFunctionQue();

		public function DataStorage(vk:VKCommunicator) {
			vkCommunicator = vk;
		}

		public function requestUserBestResult():void {
			userBestResultCome = false;
			timerFunctionQue.addFunction(new VKFunction(vkCommunicator.getUserBestResult,
					getUserBestResultHandler));
		}

		public function update():void {
			if (userRightAnswerCount < rightAnswerCount) {
				//Alert.show("записать лучший рез. пользователя " + serializeResult(questionCount, rightAnswerCount));
				userBestResultIsSet = false;
				timerFunctionQue.addFunction(new VKFunction(vkCommunicator.setUserBestResult,
						userBestResultSetHandler,
						serializeResult(questionCount, rightAnswerCount)));
			} else {
				userBestResultIsSet = true;
			}
			appBestResultCome = false;
			timerFunctionQue.addFunction(new VKFunction(vkCommunicator.getAppBestResult,
					getAppBestResultHandler));
			userCome = false;
			timerFunctionQue.addFunction(new VKFunction(vkCommunicator.getBestUser,
					getBestUserHandler));
		}

		private function getBestUserHandler(user:User):void {
			bestUser = user;
			userCome = true;
		}

		private function getUserBestResultHandler(data:Object):void {
			//Alert.show("Получить лучший результат пользователя " + data);
			if (!data) {
				//Alert.show("!data");
				userQuestionCount = questionCount;
				userRightAnswerCount = rightAnswerCount;
				userBestResultCome = true;
				return;
			}
			var result:String = String(data);
			userQuestionCount = parseQuestionCount(result);
			userRightAnswerCount = parseRightAnswerCount(result);

			userBestResultCome = true;
		}

		private function userBestResultSetHandler(data:Object):void {
			//Alert.show("Лучший рез. пользователя записан");
			userBestResultIsSet = true;
		}

		private function appBestResultSetHandler(data:Object):void {
			//Alert.show("Лучший рез. приложения записан");
			appBestResultIsSet = true;
		}

		private function setUserHandler(data:Object):void {
			//Alert.show("Лучший пользователь записан");
			userIsSet = true;
		}

		private function getAppBestResultHandler(data:Object):void {
			//Alert.show("Лучший рез. приложения " + data);
			if (!data) {
				appQuestionCount = 0;
				appRightAnswerCount = 0;
				appBestResultCome = true;
				return;
			}
			var result:String = String(data);
			appQuestionCount = parseQuestionCount(result);
			appRightAnswerCount = parseRightAnswerCount(result);
			appBestResultCome = true;
			if (rightAnswerCount > appRightAnswerCount) {
				//Alert.show("записать лучший рез. приложения " + serializeResult(questionCount, rightAnswerCount));
				appBestResultIsSet = false;
				timerFunctionQue.addFunction(new VKFunction(vkCommunicator.setAppBestResult,
						appBestResultSetHandler,
						serializeResult(questionCount, rightAnswerCount)));
				//Alert.show("записать лучший рез. приложения");
				userIsSet = false;
				timerFunctionQue.addFunction(new VKFunction(vkCommunicator.setBestUserId,
						setUserHandler));
			}
		}

		private function parseRightAnswerCount(result:String):int {
			var pos:int = result.indexOf("/");
			return parseInt(result.substring(0, pos));
		}

		private function parseQuestionCount(result:String):int {
			var pos:int = result.indexOf("/");
			return parseInt(result.substring(pos + 1));
		}

		private function serializeResult(questionCount:int,
				rightAnswerCount:int):String {
			return rightAnswerCount + "/" + questionCount;
		}
	}
}

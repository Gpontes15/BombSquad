#define BLUE_JUMPER_PIN 13
#define RED_JUMPER_PIN 32

#define GREEN_LED_PIN 25
#define RED_LED_PIN 12

int correct_jumper = 0;

enum JUMPER {
	None = 0,
	RED = 1,
	BLUE = 2
};

void setup() {
	// bluetooth?
	correct_jumper = RED;

	pinMode(RED_LED_PIN, OUTPUT);
	pinMode(GREEN_LED_PIN, OUTPUT);
	pinMode(RED_JUMPER_PIN, INPUT_PULLUP);
	pinMode(BLUE_JUMPER_PIN, INPUT_PULLUP);
	
	digitalWrite(RED_LED_PIN, LOW);
	digitalWrite(GREEN_LED_PIN, LOW);
}


void loop() {
	bool isRedJumperHigh = digitalRead(RED_JUMPER_PIN) == HIGH;
	bool isBlueJumperHigh = digitalRead(BLUE_JUMPER_PIN) == HIGH;

	if (isRedJumperHigh && isBlueJumperHigh) {
		digitalWrite(GREEN_LED_PIN, LOW);
		digitalWrite(RED_LED_PIN, LOW);
	}
	if (!isRedJumperHigh && !isBlueJumperHigh) {
		digitalWrite(GREEN_LED_PIN, LOW);
		digitalWrite(RED_LED_PIN, LOW);
	}
	if (isRedJumperHigh && !isBlueJumperHigh) {
		if (correct_jumper == BLUE) {
			digitalWrite(GREEN_LED_PIN, HIGH);
			digitalWrite(RED_LED_PIN, LOW);
		} else {
			digitalWrite(RED_LED_PIN, HIGH);
			digitalWrite(GREEN_LED_PIN, LOW);
		}
	}
	if (!isRedJumperHigh && isBlueJumperHigh) {
		if (correct_jumper == RED) {
			digitalWrite(GREEN_LED_PIN, HIGH);
			digitalWrite(RED_LED_PIN, LOW);
		} else {
			digitalWrite(RED_LED_PIN, HIGH);
			digitalWrite(GREEN_LED_PIN, LOW);
		}
	}

}

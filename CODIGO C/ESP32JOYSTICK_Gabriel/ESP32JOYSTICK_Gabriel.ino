#include <BleKeyboard.h>

#define JOYSTICK_X_PIN 27 // Pino analógico para o joystick horizontal
#define JOYSTICK_Y_PIN 32 // Pino analógico para o joystick vertical
#define btn 26 // Pino digital para o botão

BleKeyboard blekeyboard("ESP32 Gabriel", "Espressif", 100);

void setup() {
  Serial.begin(115200);   // Define a taxa de transmissão para comunicação serial
  pinMode(btn, INPUT_PULLUP); // Define o pino do botão como entrada com pull-up interno
  blekeyboard.begin();    // Inicia a comunicação Bluetooth
}

void loop() {
  if (digitalRead(btn) == LOW) {
    if (blekeyboard.isConnected()) {
      blekeyboard.press(KEY_RETURN);
      delay(100);
      blekeyboard.release(KEY_RETURN);
    }
  }

  int x_adc_val, y_adc_val; 
  float x_volt, y_volt;
  
  // Leitura dos valores dos pinos dos joysticks
  x_adc_val = analogRead(JOYSTICK_X_PIN); 
  y_adc_val = analogRead(JOYSTICK_Y_PIN);

  // Aplicar um filtro simples para evitar movimentos involuntários
  if (abs(x_adc_val - 2048) < 200) x_adc_val = 2048;
  if (abs(y_adc_val - 2048) < 200) y_adc_val = 2048;
  
  // Conversão dos valores analógicos para voltagem
  x_volt = (x_adc_val * 3.3) / 4095;
  y_volt = (y_adc_val * 3.3) / 4095;

  // Verificar movimento na horizontal (joystick esquerda/direita)
  if (x_volt < 1.0) { // Movimento para a esquerda (interpretado como para baixo)
    if (blekeyboard.isConnected()) {
      blekeyboard.press(KEY_DOWN_ARROW); // Pressiona a tecla de seta para baixo
    }
    blekeyboard.release(KEY_UP_ARROW); // Libera a tecla de seta para cima
  } else if (x_volt > 2.5) { // Movimento para a direita (interpretado como para cima)
    if (blekeyboard.isConnected()) {
      blekeyboard.press(KEY_UP_ARROW); // Pressiona a tecla de seta para cima
    }
    blekeyboard.release(KEY_DOWN_ARROW); // Libera a tecla de seta para baixo
  } else {
    blekeyboard.release(KEY_UP_ARROW); // Libera a tecla de seta para cima
    blekeyboard.release(KEY_DOWN_ARROW); // Libera a tecla de seta para baixo
  }

  // Verificar movimento na vertical (joystick cima/baixo)
  if (y_volt < 1.0) { // Moviment6o para cima (interpretado como para a esquerda)
    if (blekeyboard.isConnected()) {
      blekeyboard.press(KEY_LEFT_ARROW); // Pressiona a tecla de seta para a esquerda
    }
    blekeyboard.release(KEY_RIGHT_ARROW); // Libera a tecla de seta para a direita
  } else if (y_volt > 2.5) { // Movimento para baixo (interpretado como para a direita)
    if (blekeyboard.isConnected()) {
      blekeyboard.press(KEY_RIGHT_ARROW); // Pressiona a tecla de seta para a direita
    }
    blekeyboard.release(KEY_LEFT_ARROW); // Libera a tecla de seta para a esquerda
  } else {
    blekeyboard.release(KEY_LEFT_ARROW); // Libera a tecla de seta para a esquerda
    blekeyboard.release(KEY_RIGHT_ARROW); // Libera a tecla de seta para a direita
  }

  delay(100);
}

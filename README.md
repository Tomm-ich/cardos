# 🎮 CardOS v1.0 — M5Stack Cardputer-Adv Firmware

Een volledig mini-besturingssysteem voor de M5Stack Cardputer-Adv met 11 apps.

## 📱 Apps

| App | Beschrijving | Besturing |
|-----|-------------|-----------|
| 🐍 **Snake** | Klassiek Snake spel, wordt sneller bij eten | WASD/pijlen, Tab=menu |
| 🏓 **Pong** | 1 of 2-speler Pong met AI tegenstander | W/S=links, I/K=rechts(2P) |
| 🧩 **Tetris** | Volledig Tetris met score & levels | A/D=beweeg, W=roteer, S=snel |
| 🎵 **Muziek** | MP3 speler van SD kaart + visualizer | A/D=track, Space=play, +/-=vol |
| 💬 **Chat** | P2P chat via ESP-NOW (geen internet!) | Type + Enter, werkt lokaal |
| 🤖 **AI Chat** | Claude AI chatbot via WiFi API | Type vraag + Enter |
| 📡 **WiFi Scan** | Scan alle netwerken met signaalsterkte | Enter=scan, W/S=scroll |
| 📺 **IR Remote** | IR afstandsbediening (LG TV preset) | Pijlen=kies, Enter=zend |
| 🕐 **Klok** | Digitale klok met IMU accelerometer | Enter=instellen |
| 📝 **Notities** | Teksteditor, opslaan op SD kaart | Typ tekst, Tab=opslaan |
| ℹ️ **Systeem** | RAM, batterij, WiFi, sensor info | Enter=ververs |

---

## ⚙️ Installatie

### Vereisten
- [PlatformIO](https://platformio.org/) (VS Code extensie aanbevolen)
- M5Stack Cardputer-Adv
- microSD kaart (FAT32, optioneel)

### Stap 1: Project openen
```bash
# Pak het zip archief uit
# Open de map in VS Code met PlatformIO
```

### Stap 2: Config aanpassen
Bewerk `include/config.h`:
```cpp
#define WIFI_SSID       "JouwWiFiNaam"
#define WIFI_PASSWORD   "JouwWiFiWachtwoord"
#define ANTHROPIC_API_KEY  "sk-ant-..."   // Van console.anthropic.com
#define CHAT_USERNAME   "CardOS"          // Jouw naam in de chat
```

### Stap 3: SD kaart (optioneel)
Maak deze mappen op de SD kaart aan:
```
/music/     → .mp3 bestanden hier
/video/     → toekomstige feature
/saves/     → game saves
```

### Stap 4: Flashen
```bash
# Zet Cardputer in download mode:
# 1. Zijschakelaar op OFF
# 2. Houd G0 knop ingedrukt
# 3. Zet schakelaar op ON
# 4. Laat G0 los

# Dan in PlatformIO:
pio run --target upload
```

---

## 🎮 Navigatie

- **Pijltjestoetsen** (of WASD) = navigeren in menu en games
- **Enter** = selecteren / bevestigen
- **Tab** = terug naar hoofdmenu (vanuit elke app)
- **Del** = wissen (in tekstvelden)

---

## 📦 Libraries (automatisch via PlatformIO)

```ini
m5stack/M5GFX
m5stack/M5Unified
m5stack/M5Cardputer
bblanchon/ArduinoJson
knolleary/PubSubClient
madhephaestus/ESP32Servo
```

### Extra voor MP3 (handmatig toevoegen aan platformio.ini):
```ini
earlephilhower/ESP8266Audio @ ^1.9.7
```

---

## 🔧 AI Chat instellen

1. Ga naar [console.anthropic.com](https://console.anthropic.com)
2. Maak een API key aan
3. Plak de key in `config.h` bij `ANTHROPIC_API_KEY`
4. De app gebruikt `claude-3-haiku` voor snelle, korte antwoorden

---

## 💬 ESP-NOW Chat

De chat werkt **zonder internet** via het ESP-NOW protocol (WiFi Direct).
- Alle Cardputers met dezelfde firmware kunnen met elkaar chatten
- Bereik: ~100m in open ruimte
- Broadcast op kanaal 1 (aanpasbaar in config.h)

---

## 🗺️ Toekomstige features (TODO)

- [ ] MP4/video speler (MJPEG van SD)
- [ ] Meshtastic LoRa integratie (met LoRa cap)
- [ ] Weerstation (met Grove sensoren)
- [ ] Password manager (versleuteld op SD)
- [ ] Morse code trainer
- [ ] Spectrum analyzer (via microfoon)
- [ ] Tetris highscore opslaan op SD
- [ ] Custom IR codes invoeren

---

## 📄 Licentie

MIT License — Vrij te gebruiken en aanpassen.

Gemaakt voor de M5Stack Cardputer-Adv community 🚀

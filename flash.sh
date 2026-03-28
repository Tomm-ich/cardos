#!/bin/bash
# ============================================================
#  CardOS - Flash Script
#  Gebruik: ./flash.sh [PORT]
#  Voorbeeld: ./flash.sh COM3       (Windows)
#             ./flash.sh /dev/ttyUSB0  (Linux)
#             ./flash.sh /dev/cu.usbserial-* (Mac)
# ============================================================

PORT=${1:-/dev/ttyUSB0}
FIRMWARE=".pio/build/cardputer-adv/firmware.bin"
BOOTLOADER=".pio/build/cardputer-adv/bootloader.bin"
PARTITIONS=".pio/build/cardputer-adv/partitions.bin"

echo "=================================="
echo "  CardOS Flash Script"
echo "=================================="
echo "Port: $PORT"
echo ""

# Check of firmware bestaat
if [ ! -f "$FIRMWARE" ]; then
    echo "❌ Firmware niet gevonden! Compileer eerst:"
    echo "   pio run"
    exit 1
fi

echo "📋 Firmware info:"
ls -lh "$FIRMWARE"
echo ""

echo "⚡ Flashen gestart..."
echo "   → Zorg dat de Cardputer in DOWNLOAD mode staat:"
echo "      1. Zijschakelaar UIT"
echo "      2. Houd G0 knop ingedrukt"
echo "      3. Zijschakelaar AAN"
echo "      4. Laat G0 los"
echo ""
read -p "Druk Enter als het apparaat klaar is..."

esptool.py \
    --chip esp32s3 \
    --port "$PORT" \
    --baud 921600 \
    --before default_reset \
    --after hard_reset \
    write_flash \
    --flash_mode dio \
    --flash_freq 80m \
    --flash_size 8MB \
    0x0000  "$BOOTLOADER" \
    0x8000  "$PARTITIONS" \
    0x10000 "$FIRMWARE"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Flash geslaagd! Herstart de Cardputer."
else
    echo ""
    echo "❌ Flash mislukt. Controleer de USB verbinding en probeer opnieuw."
fi

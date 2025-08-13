#!/bin/bash
set -e

API_KEY="MYSECRETKEY"

BACKEND_URL="http://localhost:8008"
FRONTEND_URL="http://localhost:3000"

REPORT_DIR="/home/adminden/zap-reports"
mkdir -p "$REPORT_DIR"

# Используем виртуальное окружение
/home/adminden/zap-venv/bin/python3 - <<END
from zapv2 import ZAPv2
import time

zap = ZAPv2(apikey="$API_KEY", proxies={'http':'http://127.0.0.1:8081','https':'http://127.0.0.1:8081'})

def scan_target(target, text_report_file, html_report_file):
    print(f"\n🕷️  Spidering {target}...")
    zap.spider.scan(target)
    while int(zap.spider.status()) < 100:
        time.sleep(2)
    print(f"✅ Spider complete for {target}")

    print(f"⚡ Active scanning {target}...")
    zap.ascan.scan(target)
    while int(zap.ascan.status()) < 100:
        time.sleep(5)
    print(f"✅ Active scan complete for {target}")

    alerts = zap.core.alerts(baseurl=target)

    # Читаемый текстовый отчёт
    with open(text_report_file, 'w', encoding='utf-8') as f:
        if not alerts:
            f.write(f"No alerts found for {target}.\n")
        else:
            f.write(f"ZAP Scan Report for {target}\n")
            f.write("="*70 + "\n\n")
            for i, alert in enumerate(alerts, start=1):
                f.write(f"[{i}] {alert['alert']}\n")
                f.write(f"  Risk: {alert['risk']}\n")
                f.write(f"  URL: {alert['url']}\n")
                f.write(f"  Description: {alert['description']}\n")
                f.write(f"  Solution: {alert['solution']}\n")
                f.write("-"*70 + "\n")
    
    # HTML отчёт
    html_report = zap.core.htmlreport()
    with open(html_report_file, 'w', encoding='utf-8') as f:
        f.write(html_report)

    print(f"📄 Reports saved:\n  Text: {text_report_file}\n  HTML: {html_report_file}\n")

scan_target("$BACKEND_URL", "$REPORT_DIR/backend-zap-report.txt", "$REPORT_DIR/backend-zap-report.html")
scan_target("$FRONTEND_URL", "$REPORT_DIR/frontend-zap-report.txt", "$REPORT_DIR/frontend-zap-report.html")
END

echo "✅ ZAP scanning completed. Reports saved in $REPORT_DIR"

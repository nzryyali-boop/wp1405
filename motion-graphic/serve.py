#!/usr/bin/env python3
"""
وب‌سرور کوچک برای پیش‌نمایش موشن‌گرافی و دانلود ویدیو.

    python3 serve.py            # روی پورت 8080
    python3 serve.py 3000       # روی پورت دلخواه

مسیرهای کوتاه:
    /        → پخش موشن‌گرافی (index.html)
    /dl      → دانلود مستقیم ویدیو (ریدایرکت به gahar.mp4)
فایل‌های mp4 با هدر «attachment» ارسال می‌شوند تا مستقیم دانلود شوند.
"""
import os
import sys
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer

PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8080
ROOT = os.path.dirname(os.path.abspath(__file__))
MP4_NAME = "gahar-motion-1080x1920.mp4"


class Handler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=ROOT, **kwargs)

    def do_GET(self):
        clean = self.path.split("?")[0].rstrip("/").lower()
        if clean in ("/dl", "/download", "/video"):
            self.send_response(302)
            self.send_header("Location", "/gahar.mp4")
            self.send_header("Cache-Control", "no-store")
            self.end_headers()
            return
        if clean in ("", "/watch"):
            self.path = "/index.html"
        return super().do_GET()

    def end_headers(self):
        path = self.path.split("?")[0].lower()
        if path.endswith(".mp4"):
            self.send_header("Content-Disposition", 'attachment; filename="%s"' % MP4_NAME)
            self.send_header("Cache-Control", "no-store")
        self.send_header("Accept-Ranges", "bytes")
        super().end_headers()

    def log_message(self, fmt, *args):
        sys.stderr.write("%s - %s\n" % (self.address_string(), fmt % args))


if __name__ == "__main__":
    srv = ThreadingHTTPServer(("0.0.0.0", PORT), Handler)
    print("serving %s on http://0.0.0.0:%d" % (ROOT, PORT), flush=True)
    srv.serve_forever()

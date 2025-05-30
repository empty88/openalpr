from openalpr import Alpr

import json
import tornado.ioloop
import tornado.web
import os

alpr = Alpr("eu", "/etc/openalpr/openalpr.conf", "/usr/share/openalpr/runtime_data")
alpr.set_top_n(10)
alpr.set_default_region("de")
alpr.set_detect_region(False)

class MainHandler(tornado.web.RequestHandler):
    def post(self):
        print("start", flush=True)
        if 'image' not in self.request.files:
            self.finish('Image parameter not provided')

        fileinfo = self.request.files['image'][0]
        jpeg_bytes = fileinfo['body']

        if len(jpeg_bytes) <= 0:
            return False
        print("analyzing " + fileinfo.filename, flush=True)
        results = alpr.recognize_array(jpeg_bytes)

        if "plate" in json.dumps(results):
            print("plate found: " + results["results"][0]["plate"])
        print("end", flush=True)
        self.finish(json.dumps(results))

application = tornado.web.Application([
    (r"/alpr", MainHandler),
])

if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.current().start()

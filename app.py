import pytube
from flask import Flask, request, jsonify
from flask_restful import Api

app = Flask(__name__)
api = Api(app)

#Get Link
@app.route("/videos", methods=["POST"])
def download_video():
    link = request.get_json().get("link")
    if link:
        try:
            yt = pytube.YouTube(link)
            stream = yt.streams.get_highest_resolution()
            stream.download()
            return jsonify({"message": "Download successful"})
        except Exception as e:
            return jsonify({"error": str(e)}), 500
    else:
        return jsonify({"error": "Link not provided"}), 400


if __name__ == '__main__':
    app.run()

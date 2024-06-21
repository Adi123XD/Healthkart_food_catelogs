from flask import Flask, jsonify, request
from flask_cors import CORS
import werkzeug
import werkzeug.utils

app = Flask(__name__)
CORS(app)
port =8000

@app.route('/api/message', methods=['GET'])
def get_message():
    return jsonify({"message": "Backend will be built soon"})

@app.route('/api/upload_image',methods=['POST'])
def get_image_content():
    if (request.method=="POST"):
        imagefile = request.files['image']
        filename = werkzeug.utils.secure_filename(imagefile.filename)
        imagefile.save("./uploaded_images/"+filename)
        return jsonify({
            "message":"Image uploaded successfully"
        })

if __name__ == '__main__':
    print(f"Server is listening to http://127.0.0.1:{port}")
    app.run(debug=True, port=port)

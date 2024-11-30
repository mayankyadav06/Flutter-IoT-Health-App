from flask import Flask, jsonify
import random

app = Flask(__name__)

# Set up the temperature and heart rate data range
TEMP_MIN = 20
TEMP_MAX = 30
HR_MIN = 60
HR_MAX = 100

@app.route('/api/sensor_data', methods=['GET'])
def get_sensor_data():
    # Generate random temperature and heart rate values
    temperature = random.uniform(TEMP_MIN, TEMP_MAX)
    heart_rate = random.randint(HR_MIN, HR_MAX)

    # Prepare the response data
    data = {
        "temperature": round(temperature, 2),
        "heartRate": heart_rate
    }

    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0', port=5000)

from flask import Flask, request
import serial
import os

# Flask 앱 초기화
app = Flask(__name__)

# 업로드된 파일을 저장할 폴더
UPLOAD_FOLDER = 'uploads'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# UART 설정 (필요에 따라 포트와 속도를 설정)
UART_PORT = '/dev/ttyUSB0'  # Linux 환경에서 UART 포트 (Windows는 'COMx')
UART_BAUDRATE = 115200

# 비트스트림 파일을 UART로 전송하는 함수
def send_bitstream_via_uart(filepath):
    try:
        with serial.Serial(UART_PORT, UART_BAUDRATE, timeout=1) as uart:
            with open(filepath, 'rb') as bitstream_file:
                while (chunk := bitstream_file.read(1024)):  # 1KB씩 전송
                    uart.write(chunk)
            return True
    except serial.SerialException as e:
        print(f"UART 통신 오류: {e}")
        return False

# 비트스트림 파일 업로드 및 전송 경로
@app.route('/', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        if 'file' not in request.files:
            return 'No file part'
        file = request.files['file']
        if file.filename == '':
            return 'No selected file'
        if file and file.filename.endswith('.bit'):  # 비트스트림 파일 체크
            filepath = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
            file.save(filepath)
            success = send_bitstream_via_uart(filepath)
            if success:
                return f'File {file.filename} uploaded and sent to FPGA!'
            else:
                return 'Failed to send file via UART.'
        else:
            return 'Please upload a valid .bit file!'
    return '''
    <!doctype html>
    <title>Upload Bitstream File</title>
    <h1>Upload a .bit file to FPGA</h1>
    <form method=post enctype=multipart/form-data>
      <input type=file name=file>
      <input type=submit value=Upload>
    </form>
    '''

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')  # 네트워크에서 접근 가능하도록 서버 실행

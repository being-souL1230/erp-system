from flask import Flask, render_template, request, redirect, url_for, session, make_response,flash  # type: ignore
import pymysql # type: ignore
import csv
import os
app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Session ke liye zaroori hai

# Database connection
def get_db_connection():
    return pymysql.connect(
        host='localhost',
        user='root',
        password='00$ouL00',
        database='student_management'
    )
    

# ✅ Cache bypass for all routes
@app.after_request
def add_header(response):
    response.headers['Cache-Control'] = 'no-store, no-cache, must-revalidate, max-age=0'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
    return response

@app.route('/')
def index():
    response = make_response(render_template('home.html'))

    # Cache bypass for home page
    response.headers['Cache-Control'] = 'no-store, no-cache, must-revalidate, max-age=0'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'

    return response

# ✅ Student Login
@app.route('/student_login')
def student_login():
    return render_template('login.html')

@app.route('/login', methods=['POST'])
def login():
    email = request.form['email']
    password = request.form['password']

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM students WHERE email = %s AND password = %s', (email, password))
    user = cursor.fetchone()

    if user:
        session['student_id'] = user[0]
        conn.close()
        return redirect(url_for('student_dashboard'))
    else:
        conn.close()
        return "Invalid email or password!"

# ✅ Student Dashboard
@app.route('/student_dashboard')
def student_dashboard():
    if 'student_id' not in session:
        return redirect(url_for('student_login'))

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM students WHERE id = %s', (session['student_id'],))
    student = cursor.fetchone()
    conn.close()
    return render_template('dashboard.html', student=student)

# ✅ View Assignments
@app.route('/view_assignments')
def view_assignments():
    if 'student_id' not in session:
        return redirect(url_for('student_login'))

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM assignments')
    assignments = cursor.fetchall()
    conn.close()
    return render_template('assignments.html', assignments=assignments)

# ✅ Faculty Login
@app.route('/faculty_login')
def faculty_login():
    return render_template('faculty_login.html')

@app.route('/faculty_auth', methods=['POST'])
def faculty_auth():
    email = request.form['email']
    password = request.form['password']

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM faculty WHERE email = %s AND password = %s', (email, password))
    faculty = cursor.fetchone()

    if faculty:
        session['faculty_id'] = faculty[0]
        conn.close()
        return redirect(url_for('faculty_dashboard'))
    else:
        conn.close()
        return "Invalid email or password!"

# ✅ Faculty Dashboard
@app.route('/faculty_dashboard')
def faculty_dashboard():
    if 'faculty_id' not in session:
        return redirect(url_for('faculty_login'))

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT id, name, email FROM faculty')
    faculty_data = cursor.fetchall()
    conn.close()
    return render_template('faculty_dashboard.html', faculties=faculty_data)

# ✅ Faculty Table
@app.route('/faculty_table')
def faculty_table():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT id, name, email FROM faculty')
    faculty_data = cursor.fetchall()
    conn.close()
    return render_template('faculty_table.html', faculties=faculty_data)

# ✅ Faculty Profile with Unauthorized Access Check
@app.route('/faculty_profile/<int:faculty_id>')
def faculty_profile(faculty_id):
    if 'faculty_id' not in session or faculty_id != session['faculty_id']:
        return "Unauthorized access", 403

    conn = get_db_connection()
    cursor = conn.cursor()

    # Faculty info
    cursor.execute('SELECT * FROM faculty WHERE id = %s', (faculty_id,))
    faculty = cursor.fetchone()

    if not faculty:
        conn.close()
        return "Faculty not found"

    # Faculty schedule
    cursor.execute('SELECT faculty_name, day_of_week, period_time, subject FROM period_schedule WHERE faculty_name = %s', (faculty[1],))
    schedule = cursor.fetchall()

    conn.close()

    return render_template('faculty_profile.html', faculty=faculty, schedule=schedule)

# ✅ Upload CSV and Insert into MySQL
@app.route('/upload_csv', methods=['POST'])
def upload_csv():
    if 'faculty_id' not in session:
        return "Unauthorized access", 403
    
    if 'file' not in request.files:
        flash("No file part", "error")
        return redirect(url_for('faculty_profile', faculty_id=session['faculty_id']))

    file = request.files['file']

    if file.filename == '':
        flash("No selected file", "error")
        return redirect(url_for('faculty_profile', faculty_id=session['faculty_id']))

    if file and file.filename.endswith('.csv'):
        conn = get_db_connection()
        cursor = conn.cursor()

        try:
            stream = file.stream.read().decode("utf-8").splitlines()
            csv_reader = csv.reader(stream)
            
            next(csv_reader)  # ✅ Skip header row
            
            for row in csv_reader:
                # ✅ 5 columns me data le rahe hain
                name, day, time, subject, class_name = row  
                cursor.execute('''
                    INSERT INTO period_schedule (faculty_name, day_of_week, period_time, subject, class)
                    VALUES (%s, %s, %s, %s, %s)
                ''', (name, day, time, subject, class_name))  # ✅ Class bhi insert ho rahi hai
            
            conn.commit()
            flash("CSV uploaded and data inserted successfully!", "success")
        
        except Exception as e:
            flash(f"Error: {str(e)}", "error")
            conn.rollback()
        
        finally:
            cursor.close()
            conn.close()

        return redirect(url_for('faculty_profile', faculty_id=session['faculty_id']))

    flash("Invalid file format. Only .csv allowed!", "error")
    return redirect(url_for('faculty_profile', faculty_id=session['faculty_id']))

# ✅ Attendance Check
@app.route('/check_attendance', methods=['GET', 'POST'])
def check_attendance():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute('SELECT id, name, attendance FROM students')
    attendance_data = cursor.fetchall()
    conn.close()
    return render_template('attendance.html', attendance_data=attendance_data)

@app.route('/classes')
def classes():
    return render_template('classes.html')

@app.route('/mcu_classes')
def mcu_classes():
    return render_template('mcu_classes.html')

@app.route('/bca_csjmu')
def bca_csjmu():
    return render_template('bca_csjmu.html')

@app.route('/bba')
def bba():
    return render_template('bba.html')

# ✅ Courses Page
@app.route('/courses')
def courses():
    return render_template('course.html')

# ✅ Coordinators Page
@app.route('/coordinators')
def coordinators():
    return render_template('coordinators.html')

@app.route('/period_schedule', methods=['GET'])
def period_schedule():
    selected_class = request.args.get('class')  # Get the 'class' parameter from the URL
    conn = get_db_connection()
    cursor = conn.cursor()

    if selected_class:
        # Filter schedule by the selected class
        cursor.execute('''
            SELECT faculty_name, day_of_week, period_time, subject, class 
            FROM period_schedule
            WHERE class = %s
        ''', (selected_class,))
    else:
        # If no class is selected, show all schedules
        cursor.execute('SELECT faculty_name, day_of_week, period_time, subject, class FROM period_schedule')
    
    schedule = cursor.fetchall()
    conn.close()
    return render_template('period_schedule.html', schedule=schedule, selected_class=selected_class)


# ✅ Logout Route with History Clear
@app.route('/logout')
def logout():
    session.clear()

    response = make_response(redirect(url_for('index')))

    # Cache bypass
    response.headers['Cache-Control'] = 'no-store, no-cache, must-revalidate, max-age=0'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'

    # History clear using JavaScript
    response.set_data('''
    <script>
        history.pushState(null, '', '/');
        history.replaceState(null, '', '/');
        window.location.replace('/');
    </script>''')

    return response

if __name__ == '__main__':
    app.run(debug=True)
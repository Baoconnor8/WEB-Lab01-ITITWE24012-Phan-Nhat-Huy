DROP DATABASE IF EXISTS lab1_university;
CREATE DATABASE lab1_university
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE lab1_university;

--  TABLES
CREATE TABLE Department (
    DepartmentID    VARCHAR(10)     NOT NULL,
    DepartmentName  VARCHAR(100)    NOT NULL,
    CONSTRAINT pk_department PRIMARY KEY (DepartmentID)
);
-- 2. Student
CREATE TABLE Student (
    StudentID   VARCHAR(15)     NOT NULL,
    StudentName VARCHAR(100)    NOT NULL,
    DoB         DATE            NOT NULL,
    Major       VARCHAR(100)    NOT NULL,
    CONSTRAINT pk_student PRIMARY KEY (StudentID)
);
-- 3. Course
CREATE TABLE Course (
    CourseID    VARCHAR(10)     NOT NULL,
    CourseName  VARCHAR(150)    NOT NULL,
    CONSTRAINT pk_course PRIMARY KEY (CourseID)
);

-- 4. Lecturer  (belongs to one Department → FK)
CREATE TABLE Lecturer (
    LecturerID      VARCHAR(10)     NOT NULL,
    LecturerName    VARCHAR(100)    NOT NULL,
    DepartmentID    VARCHAR(10)     NOT NULL,
    CONSTRAINT pk_lecturer      PRIMARY KEY (LecturerID),
    CONSTRAINT fk_lect_dept     FOREIGN KEY (DepartmentID)
                                REFERENCES Department(DepartmentID)
                                ON UPDATE CASCADE
                                ON DELETE RESTRICT
);

-- 5. Register  (Student ↔ Course  many-to-many)
CREATE TABLE Register (
    StudentID   VARCHAR(15)     NOT NULL,
    CourseID    VARCHAR(10)     NOT NULL,
    RegisterDate DATE           DEFAULT (CURRENT_DATE),
    CONSTRAINT pk_register      PRIMARY KEY (StudentID, CourseID),
    CONSTRAINT fk_reg_student   FOREIGN KEY (StudentID)
                                REFERENCES Student(StudentID)
                                ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_reg_course    FOREIGN KEY (CourseID)
                                REFERENCES Course(CourseID)
                                ON UPDATE CASCADE ON DELETE CASCADE
);

-- 6. Teach  (Course ↔ Lecturer  many-to-many)
CREATE TABLE Teach (
    CourseID    VARCHAR(10)     NOT NULL,
    LecturerID  VARCHAR(10)     NOT NULL,
    Semester    VARCHAR(20)     DEFAULT 'Fall 2025',
    CONSTRAINT pk_teach         PRIMARY KEY (CourseID, LecturerID),
    CONSTRAINT fk_teach_course  FOREIGN KEY (CourseID)
                                REFERENCES Course(CourseID)
                                ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_teach_lect    FOREIGN KEY (LecturerID)
                                REFERENCES Lecturer(LecturerID)
                                ON UPDATE CASCADE ON DELETE CASCADE
);
--  SAMPLE DATA
-- ── Departments ──────────────────────────────────────────────
INSERT INTO Department (DepartmentID, DepartmentName) VALUES
    ('D01', 'Computer Science'),
    ('D02', 'Information Technology'),
    ('D03', 'Software Engineering'),
    ('D04', 'Data Science'),
    ('D05', 'Cybersecurity');

-- ── Students ─────────────────────────────────────────────────
INSERT INTO Student (StudentID, StudentName, DoB, Major) VALUES
    ('ITCSIU24001', 'Phan Nhat Huy',      '2006-03-15', 'Computer Science'),
    ('ITCSIU24002', 'Nguyen Minh Tri',  '2005-07-22', 'Information Technology'),
    ('ITCSIU24003', 'Tran Thi Mai',     '2006-01-10', 'Software Engineering'),
    ('ITCSIU24004', 'Pham Van Duc',     '2005-11-30', 'Computer Science'),
    ('ITCSIU24005', 'Hoang Thi Lan',    '2006-05-18', 'Data Science'),
    ('ITCSIU23001', 'Vo Thanh Hung',    '2005-09-04', 'Computer Science'),
    ('ITCSIU23002', 'Dang Ngoc Mai',   '2004-12-25', 'Cybersecurity'),
    ('ITCSIU23003', 'Bui Xuan Nam',     '2005-03-08', 'Information Technology');

-- ── Courses ──────────────────────────────────────────────────
INSERT INTO Course (CourseID, CourseName) VALUES
    ('IT001',  'Introduction to Programming'),
    ('IT002',  'Data Structures & Algorithms'),
    ('IT003',  'Database Systems'),
    ('IT004',  'Web Application Development'),
    ('IT005',  'Theoretical Models in Computing'),
    ('IT006',  'Computer Networks'),
    ('IT007',  'Artificial Intelligence'),
    ('IT008',  'Operating Systems');

-- ── Lecturers ────────────────────────────────────────────────
INSERT INTO Lecturer (LecturerID, LecturerName, DepartmentID) VALUES
    ('L001', 'Nguyen Trung Nghia',  'D02'),
    ('L002', 'Phuong Vo',           'D01'),
    ('L003', 'Tran Quoc Khanh',     'D03'),
    ('L004', 'Le Thi Huong',        'D04'),
    ('L005', 'Hoang Van Minh',      'D05');

-- ── Registrations ────────────────────────────────────────────
INSERT INTO Register (StudentID, CourseID, RegisterDate) VALUES
    ('ITCSIU24001', 'IT004', '2025-09-01'),
    ('ITCSIU24001', 'IT005', '2025-09-01'),
    ('ITCSIU24001', 'IT003', '2025-09-01'),
    ('ITCSIU24002', 'IT001', '2025-09-02'),
    ('ITCSIU24002', 'IT003', '2025-09-02'),
    ('ITCSIU24002', 'IT006', '2025-09-02'),
    ('ITCSIU24003', 'IT002', '2025-09-01'),
    ('ITCSIU24003', 'IT004', '2025-09-01'),
    ('ITCSIU24004', 'IT001', '2025-09-03'),
    ('ITCSIU24004', 'IT007', '2025-09-03'),
    ('ITCSIU24005', 'IT007', '2025-09-02'),
    ('ITCSIU24005', 'IT004', '2025-09-02'),
    ('ITCSIU23001', 'IT008', '2024-09-01'),
    ('ITCSIU23001', 'IT122', '2024-09-01'),
    ('ITCSIU23002', 'IT006', '2024-09-02'),
    ('ITCSIU23002', 'IT008', '2024-09-02'),
    ('ITCSIU23003', 'IT001', '2024-09-01'),
    ('ITCSIU23003', 'IT003', '2024-09-01');

-- ── Teaching assignments ─────────────────────────────────────
INSERT INTO Teach (CourseID, LecturerID, Semester) VALUES
    ('IT004', 'L001', 'Fall 2025'),
    ('IT003', 'L001', 'Fall 2025'),
    ('IT005', 'L002', 'Fall 2025'),
    ('IT002', 'L002', 'Fall 2025'),
    ('IT001', 'L003', 'Fall 2025'),
    ('IT008', 'L003', 'Fall 2025'),
    ('IT007', 'L004', 'Fall 2025'),
    ('IT006', 'L005', 'Fall 2025'),
    ('IT001', 'L001', 'Spring 2025'),
    ('IT004', 'L003', 'Spring 2025');

-- ============================================================
--  SAMPLE QUERIES  (for verification)
-- ============================================================

-- Q1: All students and their majors
SELECT StudentID, StudentName, DoB, Major
FROM   Student
ORDER  BY StudentID;

-- Q2: Courses registered by Le Quoc Bao
SELECT c.CourseID, c.CourseName, r.RegisterDate
FROM   Register r
JOIN   Course   c ON r.CourseID = c.CourseID
WHERE  r.StudentID = 'ITCSIU24001';

-- Q3: Lecturers and their departments
SELECT l.LecturerID, l.LecturerName, d.DepartmentName
FROM   Lecturer   l
JOIN   Department d ON l.DepartmentID = d.DepartmentID
ORDER  BY d.DepartmentName;

-- Q4: Which lecturer teaches which course (Fall 2025)
SELECT c.CourseName, l.LecturerName, t.Semester
FROM   Teach    t
JOIN   Course   c ON t.CourseID   = c.CourseID
JOIN   Lecturer l ON t.LecturerID = l.LecturerID
WHERE  t.Semester = 'Fall 2025'
ORDER  BY c.CourseName;

-- Q5: Number of students registered per course
SELECT c.CourseName, COUNT(r.StudentID) AS TotalStudents
FROM   Course    c
LEFT   JOIN Register r ON c.CourseID = r.CourseID
GROUP  BY c.CourseID, c.CourseName
ORDER  BY TotalStudents DESC;
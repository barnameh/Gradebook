require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  test "can create a new student" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    student_peter = Student.new(user_id: peter.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    assert student_peter.save!
  end

  test "user_id is required" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    student = Student.new(teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    assert_not student.save
  end

  test "teacher_id is required" do
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    student_peter = Student.new(user_id: peter.id, grade_level: 9, status: "enrolled")
    assert_not student_peter.save
  end

  test "can get student's email" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    student_peter = Student.create!(user_id: peter.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    assert_equal "peter@example.com", student_peter.user.email
  end

  test "can get student's teacher's email" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    student_peter = Student.create!(user_id: peter.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    assert_equal "john@example.com", student_peter.teacher.user.email
  end

  test "can get student's parents" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    lisa = User.create!(name: "Lisa", email: "lisa@example.com", password: "lisaIshere")
    bob = User.create!(name: "Bob", email: "bob@example.com", password: "bobIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    student_peter = Student.create!(user_id: peter.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    Parent.create!(user_id: lisa.id, student_id: student_peter.id, phone: "202_555_2222")
    Parent.create!(user_id: bob.id, student_id: student_peter.id, phone: "202_555_2222")
    assert_equal 2, student_peter.parents.count
  end

  test "can get student's grades" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    student_peter = Student.create!(user_id: peter.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    Grade.create!(student_id: student_peter.id, assignment_name: "gravity",
                  assignment_date: Time.new(2016, 10, 21), grade: "B")
    Grade.create!(student_id: student_peter.id, assignment_name: "velocity",
                  assignment_date: Time.new(2016, 11, 21), grade: "A")
    assert_equal 2, student_peter.grades.count
  end
end

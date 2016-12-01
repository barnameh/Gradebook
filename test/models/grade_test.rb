require 'test_helper'

class GradeTest < ActiveSupport::TestCase
  test "can create a new grade" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    student_peter = Student.create!(user_id: peter.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    student_peter_grade = Grade.new(student_id: student_peter.id, assignment_name: "gravity",
                                    assignment_date: Time.new(2016, 10, 21), grade: "B")
    assert student_peter_grade.save!
  end

  test "student must exist" do
    grade = Grade.new(assignment_name: "gravity", assignment_date: Time.new(2016, 10, 21), grade: "B")
    assert_not grade.save
  end

  test "can get grades's student email" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    student_peter = Student.create!(user_id: peter.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    student_peter_grade = Grade.create!(student_id: student_peter.id, assignment_name: "gravity",
                                        assignment_date: Time.new(2016, 10, 21), grade: "B")
    assert_equal "peter@example.com", student_peter_grade.student.user.email
  end
end

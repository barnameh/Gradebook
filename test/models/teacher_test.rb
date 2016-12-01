require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  test "can create a new teacher" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    teacher_john = Teacher.new(user_id: john.id, subject: "physics", phone: "202-555-1111")
    assert teacher_john.save!
  end

  test "user_id is required" do
    teacher = Teacher.new(subject: "physics", phone: "202-555-1111")
    assert_not teacher.save
  end

  test "can get teacher's email" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    assert_equal "john@example.com", teacher_john.user.email
  end

  test "can get teacher's students" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    ana = User.create!(name: "Ana", email: "ana@example.com", password: "anaIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    Student.create!(user_id: peter.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    Student.create!(user_id: ana.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    assert_equal 2, teacher_john.students.count
  end
end

require 'test_helper'

class ParentTest < ActiveSupport::TestCase
  test "can create a new student" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    lisa = User.create!(name: "Lisa", email: "lisa@example.com", password: "lisaIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    student_peter = Student.create!(user_id: peter.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    parent_lisa = Parent.new(user_id: lisa.id, student_id: student_peter.id, phone: "202_555_2222")
    assert parent_lisa.save!
  end

  test "user_id is required" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    student_peter = Student.create!(user_id: peter.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    parent = Parent.new(student_id: student_peter.id, phone: "202_555_2222")
    assert_not parent.save
  end

  test "student_id is required" do
    lisa = User.create!(name: "Lisa", email: "lisa@example.com", password: "lisaIshere")
    parent_lisa = Parent.new(user_id: lisa.id, phone: "202_555_2222")
    assert_not parent_lisa.save
  end

  test "can get parent's email" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    lisa = User.create!(name: "Lisa", email: "lisa@example.com", password: "lisaIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    student_peter = Student.create!(user_id: peter.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    parent_lisa = Parent.create!(user_id: lisa.id, student_id: student_peter.id, phone: "202_555_2222")
    assert_equal "lisa@example.com", parent_lisa.user.email
  end

  test "can get parent's child's email" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    lisa = User.create!(name: "Lisa", email: "lisa@example.com", password: "lisaIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    student_peter = Student.create!(user_id: peter.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    parent_lisa = Parent.create!(user_id: lisa.id, student_id: student_peter.id, phone: "202_555_2222")
    assert_equal "peter@example.com", parent_lisa.student.user.email
  end
end

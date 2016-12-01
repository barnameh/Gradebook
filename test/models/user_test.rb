require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "can create a new user" do
    john = User.new(name: "John", email: "john@example.com", password: "johnIshere")
    assert john.save!
  end

  test "name is required" do
    john = User.new(email: "john@example.com", password: "johnIshere")
    assert_not john.save
  end

  test "email is required" do
    john = User.new(name: "John", password: "johnIshere")
    assert_not john.save
  end

  test "password is required" do
    adam = User.new(name: "john", email: "john@example.com")
    assert_not adam.save
  end

  test "email should be unique" do
    User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.new(name: "peter", email: "john@example.com", password: "peterIshere")
    assert_not peter.save
  end

  test "can check if a user is a teacher" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    Student.create!(user_id: peter.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    assert john.teacher?
    assert_not peter.teacher?
  end

  test "can check if a user is a student" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    Student.create!(user_id: peter.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    assert peter.student?
    assert_not john.student?
  end

  test "can check if a user is a parent" do
    john = User.create!(name: "John", email: "john@example.com", password: "johnIshere")
    peter = User.create!(name: "Peter", email: "peter@example.com", password: "peterIshere")
    lisa = User.create!(name: "Lisa", email: "lisa@example.com", password: "lisaIshere")
    teacher_john = Teacher.create!(user_id: john.id, subject: "physics", phone: "202-555-1111")
    student_peter = Student.create!(user_id: peter.id, teacher_id: teacher_john.id, grade_level: 9, status: "enrolled")
    Parent.create!(user_id: lisa.id, student_id: student_peter.id, phone: "202_555_2222")
    assert lisa.parent?
    assert_not lisa.teacher?
  end
end

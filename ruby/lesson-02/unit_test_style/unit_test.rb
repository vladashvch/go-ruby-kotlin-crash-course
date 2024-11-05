# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../lesson-01/student'

setup_reporters('ruby/lesson-02/unit_test_style/reports')

class UnitTest < Minitest::Test
  def setup
    @student1 = Student.add_student('Sh', 'Vlada', '28/10/2000')
    @student2 = Student.add_student('Spanch', 'Harry', '5/12/1989')
    @student3 = Student.add_student('Hungry', 'Tom', '10/05/2013') 
  end

  def teardown
    Student.clean_students
  end

  def test_initialization
    assert_equal 'Sh', @student1.surname
    assert_equal 'Vlada', @student1.name
    assert_instance_of Date, @student1.date_of_birth
    assert_equal Date.parse('28/10/2000'), @student1.date_of_birth
  end

  def test_invalid_date_of_birth
    assert_raises(ArgumentError) do
      Student.add_student('Sh2', 'Vlada2', (Date.today + 1).to_s)
    end
  end

  def test_calculate_age
    assert_equal expected_age(@student1.date_of_birth), @student1.calculate_age
    assert_equal expected_age(@student2.date_of_birth), @student2.calculate_age
    assert_equal expected_age(@student3.date_of_birth), @student3.calculate_age
  end

  def test_add_student
    student4 = Student.add_student('SomeSurname', 'SomeName', '12/12/1912')
  
    assert_includes Student.get_all_students, student4
    assert_equal 'SomeSurname', student4.surname
    assert_equal 'SomeName', student4.name
    assert_equal Date.parse('12/12/1912'), student4.date_of_birth
  end

  def test_duplicate_student
    assert_raises(ArgumentError) do
      Student.add_student(@student2.surname, @student2.name, @student2.date_of_birth.to_s)
    end
  end

  def test_remove_student
    delete_student_name = @student3.name
    Student.remove_student(@student3)
    assert_equal [], Student.get_students_by_name(delete_student_name)
    assert_equal 2, Student.get_all_students.size

    expected_students = [
      @student1,
      @student2
    ]

    assert_equal expected_students.map(&:surname), Student.get_all_students.map(&:surname)
    assert_equal expected_students.map(&:name), Student.get_all_students.map(&:name)
    assert_equal expected_students.map(&:date_of_birth), Student.get_all_students.map(&:date_of_birth)
  end

  def test_get_students_by_age
    students_age = Student.get_students_by_age(expected_age(@student1.date_of_birth))
    assert_includes students_age, @student1
    assert_equal 1, students_age.size

    students_age = Student.get_students_by_age(expected_age(@student1.date_of_birth)+1)
    assert_empty students_age
    assert_equal 0, students_age.size
  end

  def test_get_students_by_name
    students_named_harry = Student.get_students_by_name(@student2.name)
    assert_includes students_named_harry, @student2
    assert_equal 1, students_named_harry.size

    students_named_bob = Student.get_students_by_name('NonexistentName')
    assert_empty students_named_bob
    assert_equal 0, students_named_bob.size
  end

  def test_get_all_students
    assert_equal 3, Student.get_all_students.size
  end

  def test_remove_all_students
    Student.clean_students
    assert_equal [], Student.get_all_students
  end
end
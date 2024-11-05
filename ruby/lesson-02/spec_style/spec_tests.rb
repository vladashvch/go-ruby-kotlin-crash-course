# frozen_string_literal: true

require "minitest/spec"
require_relative '../test_helper'
require_relative '../../lesson-01/student'

setup_reporters('ruby/lesson-02/spec_style/reports')

describe Student do
  before do
    @student = Student.add_student('Sh', 'Vlada', '28/10/2000')
  end

  after do
    Student.clean_students
  end

  describe 'student attributes' do
    it 'returns the surname of the student' do
      expect(@student.surname).must_equal 'Sh'
    end
    
    it 'returns the name of the student' do
      expect(@student.name).must_equal 'Vlada'
    end

    it 'returns the date of birth of the student' do
      expect(@student.date_of_birth).must_equal Date.parse('28/10/2000')
    end
  end

 describe '#add_student' do
    it 'adds a student to the list' do
      student2 = Student.add_student('Spanch', 'Harry', '5/12/1989')
      expect(Student.get_all_students).must_equal [@student, student2]
      
      expect(student2.surname).must_equal 'Spanch'
      expect(student2.name).must_equal 'Harry'
      expect(student2.date_of_birth).must_equal Date.parse('5/12/1989')
    end

    describe 'negative tests' do
      it 'must raise error for setting tomorrow date for birth date of student' do
        expect { Student.add_student('Spanch', 'Harry', (Date.today + 1).to_s) }.must_raise ArgumentError
      end

      it 'must raise error for adding a student with the same info' do
        expect { Student.add_student(
            @student.surname, 
            @student.name,
            @student.date_of_birth.to_s
          ) 
        }.must_raise ArgumentError
      end
    end  
  end

  describe '#get_age' do
    it 'returns the age of the student' do
      expect(@student.calculate_age).must_equal expected_age(@student.date_of_birth)
    end
  end

  describe '#get_students_by_age' do
    it 'returns a list of students with the same age' do
      expect(Student.get_students_by_age(expected_age(@student.date_of_birth))).must_equal [@student]
    end  
    
    it 'returns no students bacause there is no such a student' do
      expect(Student.get_students_by_age(expected_age(@student.date_of_birth)+1)).must_equal []
    end
  end

  describe '#get_students_by_name' do
    it 'returns a list of students with the same name' do
      expect(Student.get_students_by_name('Vlada')).must_equal [@student]
    end

    it 'returns no students bacause there is no such a student' do
      expect(Student.get_students_by_name('Bob')).must_equal []
    end
  end

  describe '#remove_student' do
    it 'removes a student from the list' do
      Student.remove_student(@student)
      expect(Student.get_all_students).must_equal []
    end

    it 'remove no one from the list' do
      result = Student.remove_student('Tom')  
      expect(result).must_equal false
      expect(Student.get_all_students).must_equal [@student]
    end
  end

  describe '#get_all_students' do
    it 'returns a list of all students' do
      student2 = Student.add_student('Spanch', 'Harry', '5/12/1989')
      student3 = Student.add_student('Hungry', 'Tom', '10/05/2013')
      expect(Student.get_all_students).must_equal [@student, student2, student3]
    end
  end

  describe '#remove_all_students' do
    it 'removes all students from the list' do
      Student.clean_students
      expect(Student.get_all_students).must_equal []
    end
  end
end

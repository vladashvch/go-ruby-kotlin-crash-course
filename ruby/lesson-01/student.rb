# frozen_string_literal: true

require 'date'

class Student
    @@students = []
    attr_accessor :name, :surname, :date_of_birth

    def initialize(surname, name, date_of_birth)
        self.date_of_birth = date_of_birth
        @surname = surname
        @name = name
    end

    def date_of_birth=(date_of_birth)
        date_of_birth = Date.parse(date_of_birth)
        if date_of_birth < Date.today
            @date_of_birth = date_of_birth
        else
            raise ArgumentError, 'Invalid date of birth'
        end
    end

    def calculate_age
        today = Date.today
        age = today.year - @date_of_birth.year
        age -= 1 if (
            today.month < @date_of_birth.month || 
            (today.month == @date_of_birth.month && today.day < @date_of_birth.day)
            )
        age
    end

    def self.add_student(surname, name, date_of_birth)
        if @@students.any? { |student| 
            student.surname == surname &&
            student.name == name &&
            student.date_of_birth == Date.parse(date_of_birth) 
        }
            raise ArgumentError, 'This student is already in list'
        end

        student = Student.new(surname, name, date_of_birth)
        @@students << student
        student
    end

    def self.remove_student(student)
        if student.is_a?(Student)
            @@students.delete_if do |s| 
                s.name == student.name && 
                s.surname == student.surname && 
                s.date_of_birth == student.date_of_birth
            end
        else
            false
        end
    end

    def self.get_students_by_age(age)
        @@students.select { |student| student.calculate_age == age }
    end

    def self.get_students_by_name(name)
        @@students.select { |student| student.name == name }
    end

    def self.get_all_students()
        @@students
    end

    def self.clean_students()
        @@students = []
    end
end
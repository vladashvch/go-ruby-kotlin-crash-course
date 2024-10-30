require 'date'

class Student
    @@students = []
    attr_accessor :surname, :name, :date_of_birth

    def initialize(surname, name, date_of_birth)
        @surname = surname
        @name = name
        self.date_of_birth = date_of_birth
        add_student
    end

    def date_of_birth=(date_of_birth)
        
        date_of_birth = Date.parse(date_of_birth)
        if date_of_birth < Date.today
            @date_of_birth = date_of_birth
        else
            raise ArgumentError, "Invalid date of birth"
        end
    end

    def calculate_age
        today = Date.today
        age = today.year - date_of_birth.year
        age -= 1 if today.month == date_of_birth.month && today.day < date_of_birth.day
        age
    end

    def add_student
        @@students << self unless @@students.any? { |student| 
        student.name == self.name && 
        student.surname == self.surname && 
        student.date_of_birth == self.date_of_birth }
    end

    def remove_student
        @@students.delete(self)
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
end
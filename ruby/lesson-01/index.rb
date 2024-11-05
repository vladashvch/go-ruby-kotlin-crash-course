# frozen_string_literal: true

require_relative('student')

student = Student.add_student('Sh', 'Vlada', '28/10/2000')

puts 'Surname: #{student.surname}'
puts 'Name: #{student.name}'
puts 'Date of birth: #{student.date_of_birth}'
puts 'Age: #{student.calculate_age}'

puts "Student with the age = 24: #{ Student.get_students_by_age(24).map { 
    |student| [
        'Surname: #{student.surname},', 
        'Name: #{student.name},', 
        'Date of birth: #{student.date_of_birth},', 
        'Age: #{student.calculate_age}', 
    ].join(' ') }}"
puts "Student with the name = Vlada: #{ Student.get_students_by_name('Vlada').map { 
    |student| [
        'Surname: #{student.surname},', 
        'Name: #{student.name},', 
        'Date of birth: #{student.date_of_birth},', 
        'Age: #{student.calculate_age}', 
    ].join(' ') }}"

student2 = Student.add_student('Sh2', 'Vlada2', '12/12/2002')
student3 = Student.add_student('Sh3', 'Vlada3', '12/12/2003')

p Student.get_all_students

Student.remove_student(student)
p Student.get_all_students

# add student with the same info
student4 = Student.add_student('Sh2', 'Vlada2', '12/12/2002')
p Student.get_all_students

# add student with bad date of birth
student4 = Student.add_student('Sh4', 'Vlada4', '31/10/2024')
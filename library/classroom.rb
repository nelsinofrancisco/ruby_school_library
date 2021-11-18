class Classroom
  attr_accessor :label

  def initialize(label:, *students: [])
    @label = label
    @students = students
  end

  def add_student(student)
    if !@students.include?(student)
      student.add_class(self)
      @students.push(student)
    else
      puts 'Class already have this student'
    end 
  end
end
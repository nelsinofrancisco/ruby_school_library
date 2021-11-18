class Classroom
  attr_accessor :label

  def initialize(label:)
    @label = label
    @students = []
  end

  def add_student(student)
    if @students.include?(student)
      puts 'Class already have this student'
    else
      student.add_class(self)
      @students.push(student)
    end
  end
end

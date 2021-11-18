require_relative './person'

class Student < Person
  def initialize(age:, classroom:, name: 'Unknown', parent_permission: true, classroom: [])
    super(name: name, age: age, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def add_class(classroom)
    if !@classroom.include?(classroom)
      classroom.add_student(self)
      @classroom.push(classroom)
    else
      puts 'Student already enrolled in classroom'
    end
  end
end

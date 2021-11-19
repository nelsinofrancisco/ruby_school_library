# rubocop:disable Metrics/MethodLength

require './library/student'
require './library/teacher'
require './library/rental'
require './library/book'
require './library/person'

class Library
  def initialize()
    @books = []
    @rentals = []
    @persons = []
  end

  def list_books
    puts "Your library don't have books yet add one first!" if @books.empty?

    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
    puts
  end

  def list_persons
    puts "Your library don't have persons yet add one first!" if @persons.empty?

    @persons.each do |person|
      person.validate_name
      puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    puts
  end

  def create_person
    print 'Do you want to create a student(1) or a teacher(2)? [Input the number]: '
    option = gets.chomp.to_i
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    if option == 1
      parent_permission = nil
      while parent_permission.nil?
        print 'Has parent permission? [y/n]: '
        parent_response = gets.chomp
        case parent_response
        when 'y'
          parent_permission = true
        when 'n'
          parent_permission = false
        else
          puts "That's not a valid option, valid options are: [y/n]\n\n"
        end
      end
      @persons.push(Student.new(age: age, name: name, parent_permission: parent_permission))
    else
      print 'Specialization: '
      specialization = gets.chomp
      @persons.push(Teacher.new(age: age, name: name, specialization: specialization))
    end
    puts "Person Created!\n\n"
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp.capitalize

    @books.push(Book.new(title: title, author: author))
    puts "Book created successfully\n\n"
  end

  def create_rental
    if @persons.empty? || @books.empty?
      puts "Either books or persons list are empty\n\n"
      return false
    end

    puts "Select a book from the following list by number\n\n"
    @books.each_with_index do |book, i|
      puts "#{i}) Title: #{book.title}, Author: #{book.author}"
    end
    print "\nEnter the book number: "
    book_index = gets.chomp.to_i

    if book_index.abs > @books.length
      puts "We don't have that book, try again.\n\n"
      return false
    end

    puts "Select a person from the following list by number\n\n"
    @persons.each_with_index do |person, i|
      puts "#{i}) [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    print "\nEnter the person number: "
    person_index = gets.chomp.to_i

    if person_index.abs > @persons.length
      puts "We don't have that person in our list, try again.\n\n"
      return false
    end

    print "\nDate: "
    date = gets.chomp
    @rentals.push(Rental.new(book: @books[book_index.abs], person: @persons[person_index.abs], date: date))
    puts "\"#{@books[book_index.abs].title}\" rented successfully by #{@persons[person_index.abs].name}!\n\n"
  end

  def rental_by_id
    print 'Enter the Person Id: '
    person_id = gets.chomp.to_i

    all_rentals = @rentals.select { |rental| rental.person.id == person_id }

    if all_rentals.empty?
      puts "This person never rented a book.\n\n"
    else
      puts 'Rentals:'
      all_rentals.each do |rental|
        puts "Date: #{rental.date}, Book #{rental.book.title} by #{rental.book.author}"
      end
      puts
    end
  end
end

def menu
  puts "School Library Menu:\n\n1 - List all books\n2 - List all people\n3 - Create a person"
  puts "4 - Create a book\n5 - Create a rental\n6 - List all rentals for a given person id\n7 - Exit"
  puts
  print 'Type your option: '
end

# rubocop:disable Metrics/CyclomaticComplexity
def main
  puts 'Welcome to School Library App!'
  run_app = true
  app = Library.new
  while run_app
    menu
    response = gets.chomp.to_i
    case response.positive?
    when 1
      app.list_books
    when 2
      app.list_persons
    when 3
      app.create_person
    when 4
      app.create_book
    when 5
      app.create_rental
    when 6
      app.rental_by_id
    when 7
      puts 'Thank you for using the school library app'
      run_app = false
    else
      puts "This isn't a valid option, please try again.\n\n"
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength

main

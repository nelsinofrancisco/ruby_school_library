require './corrector'
require './rentals'

class Person
  def initialize(age:, name: 'Unknown', parent_permission: true)
    @id = Random.rand(1..10_000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @corrector = Corrector.new
    @rentals = []
  end

  attr_accessor :name, :age
  attr_reader :id

  def can_use_services?
    is_of_age? || @parent_permission
  end

  def validate_name
    @name = @corrector.correct_name(@name)
  end

  def add_rental(date:, book:, rental: nil)
    if rental 
      @rentals.push(rental)
    else
      new_rental = Rental.new(date: date, book: book, person: self)
      book.rent(rental: new_rental)
      @rentals.push(new_rental)
    end
  end

  private

  # I needed to do this is order to keep the method name required
  # in the project
  # rubocop:disable Naming/PredicateName
  def is_of_age?
    @age >= 18
  end
  # rubocop:enable Naming/PredicateName
end

test = Person.new(name: 'zezinhotemumnomemuitogrande', age: 18)

puts test.name

test.validate_name

puts test.name

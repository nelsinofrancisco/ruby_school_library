require './rental'

class Book
  attr_accessor :title, :author
  attr_reader :rentals

  def initialize(title:, author:)
    @title = title
    @author = author
    @rentals = []
  end

  def rent(date:, person:, rental: nil)
    if rental
      @rentals.push(rental)
    else
      new_rental = Rental.new(date: date, book: self, person: person)
      person.add_book(rental: new_rental)
      @rentals.push(new_rental)
    end
  end
end

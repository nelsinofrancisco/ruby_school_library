require './rental'

class Book
  attr_accessor :title, :author, :rentals

  def initialize(title:, author:)
    @title = title
    @author = author
    @rentals = []
  end

  def rent(date:, person:)
    Rental.new(date: date, book: self, person: person)
  end
end

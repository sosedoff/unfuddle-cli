class Unfuddle::Command::PeopleCommand < Unfuddle::Command
  # Show all people on current account
  def index
    display 'People:'
    Unfuddle::Resources::Person.all.each do |p|
      display "- #{p.name.ljust(30)}#{p.email}"
    end
  end
end
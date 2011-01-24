class Unfuddle::Command::ProjectCommand < Unfuddle::Command
  # Show all available projects
  def index
    projects = Unfuddle::Resources::Project.all
    unless projects.empty?
      display 'Projects:'
      projects.each { |p| display "- #{p.title}" }
    else
      display 'You dont have any projects yet'
    end
  end
end
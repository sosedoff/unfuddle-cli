class Unfuddle::Command::RepositoryCommand < Unfuddle::Command
  # List all available repositories
  def index
    repos = Unfuddle::Resources::Repository.all
    unless repos.empty?
      display 'Repositories'
      repos.each do |r|
        display "- #{r.abbreviation}"
      end
    else
      display 'You dont have any repositories yet.'
    end
  end
  
  # Show repository history
  def log
    abbr = @args.empty? ? ask('Repository') : @args.first
    repo = Unfuddle::Resources::Repository.find_by_abbr(abbr)
    unless repo.nil?
      repo.changesets.reverse.each do |c|
        display "#{Date.parse(c.committer_date)} - #{c.committer_name.ljust(10)} - #{c.message}"
      end
    else
      error 'Repository was not found'
    end
  end
  
  # Checkout (clone) repository into directory
  def checkout
    repo = @args.empty? ? ask('Repository') : @args.first
    repo = Unfuddle::Resources::Repository.find_by_abbr(abbr)
    unless repo.nil?
      path = ask('Path to checkout', :default => Dir.pwd)
      shell("git clone git@doejo.unfuddle.com:doejo/bodyshopbids.git")
    else
      error 'Repository was not found'
    end
  end
  
  # Create a new repository
  def create
    display 'Create a new Unfuddle repository'
    
    repo = Unfuddle::Resources::Repository.create(
      :repository => {
        :title => ask('Name', :required => true),
        :abbreviation => ask('Slug', :required => true),
        :system => 'git',
        :projects => {
          :project => {
            :id => 24468 
          }
        }
      }
    )
  end
  
  # Delete existing repository
  def delete
    abbr = @args.empty? ? ask('Delete repository') : @args.first
    repo = Unfuddle::Resources::Repository.find_by_abbr(abbr)
    unless repo.nil?
      if ask_yesno("Delete [#{repo.title}] repository?")
        if repo.destroy
          success 'Repository has been deleted'
        else
          error 'Operation failed'
        end
      else
        display 'Cancelled'
      end
    else
      error 'Repository was not found!'
    end
  end
end
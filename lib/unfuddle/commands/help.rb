class Unfuddle::Command::HelpCommand < Unfuddle::Command
  def index
    rows = [
      ['help',            'Show this help message'],
      ['setup',           'Configure your Unfuddle account'],
      ['list',            'Show list of all repositories'],
      ['log [repo]',      'Show commit log for the repository'],
      ['add [repo]',      'Create a new new repository'],
      ['checkout [repo]', 'Clone existing repository'],
      ['init [repo]',     'Init git repo and connect it to Unfuddle'],
      ['drop [repo]',     'Delete existing repository'],
      ['projects',        'Show list of all projects']
    ]
    
    len = rows.first.map { |r| r.first.length }.sort.first
    max_len = 10 if len < 10
    
    rows.each do |r|
      puts "#{r.first.ljust(max_len+20)} # #{r.last}"
    end
  end
end
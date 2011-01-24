class Unfuddle::Command::AccountCommand < Unfuddle::Command
  def auth
    if File.exists?(Unfuddle.credentials_file)
      acc = Unfuddle::Account.load(Unfuddle.credentials_file)
      if acc.valid?
        Unfuddle::Resources::Base.set_account(acc)
        return true
      end
    end
    Unfuddle::Command.run('setup', {})
  end
  
  def setup
    display('Enter your Unfuddle credentials')
    conf = Unfuddle::Account.new
    conf.subdomain = ask('Subdomain')
    conf.user = ask('User')
    conf.password = ask_password
    conf.ssl = ask_yesno('SSL Enabled?', 'y')
    
    if conf.valid?
      conf.save(Unfuddle.credentials_file)
      success('Authentication succeed!')
    else
      error('Authentication failed.')
    end
  end
  
  # Get current account information
  def info
    acc = Unfuddle::Resources::Account.primary
    display 'Account details'
    display "- Name: #{acc.title}"
    display "- URL: #{acc.subdomain}.unfuddle.com"
    display "- Disk usage: #{(acc.disk_usage / 1024).to_i} Mb out of #{acc.features.storage} Mb"
    #display "- Created: #{acc.created_at}"
    #display "- Features:"
    #acc.features.attributes.each_pair { |k,v| display "  - #{k}: #{v}" }
  end
end
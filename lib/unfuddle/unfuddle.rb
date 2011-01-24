module Unfuddle
  @@account = nil
    
  # Get currently used account
  def self.account
    @@account
  end
  
  # Set currently used account
  def self.account=(acc)
    raise ArgumentError, 'Unfuddle::Account required!' unless acc.kind_of?(Unfuddle::Account)
    @@account = acc
  end
  
  # Get current credentials file
  def self.credentials_file
    "#{ENV['HOME']}/.unfuddle"
  end
  
  # Initialize Unfuddle 
  def self.init
    if File.exists?(credentials_file)
      
    else
      
    end
  end
end
module Unfuddle
  class Account
    attr_accessor :subdomain, :ssl
    attr_accessor :user, :password
    
    # Initialize new account
    def initialize(data=nil)
      @ssl = false
      
      unless data.nil?
        @subdomain = data[:subdomain]
        @user      = data[:user]
        @password  = data[:password]
        @ssl       = data[:ssl]
      end
    end
    
    # Validate 
    def valid?
      res = RestClient::Resource.new(
        "#{@ssl ? 'https' : 'http'}://#{@subdomain}.unfuddle.com/api/v1/account",
        :user => @user,
        :password => @password
      )
      begin
        res.get
        return true
      rescue Exception => ex
        return false
      end
    end
    
    # Get account url
    def url
      "#{@ssl ? 'https' : 'http'}://#{@subdomain}.unfuddle.com"
    end
    
    # Export to YAML
    def to_yaml
      {
        :subdomain => @subdomain,
        :user      => @user,
        :password  => @password,
        :ssl       => @ssl
      }
    end
    
    # Save configuration into file
    def save(path)
      File.open(path, 'w') { |f| f.write(YAML.dump(self.to_yaml)) }
    end
    
    # Load configuration from file
    def self.load(path)
      Account.new(YAML.load(File.read(path)))
    end
  end
end
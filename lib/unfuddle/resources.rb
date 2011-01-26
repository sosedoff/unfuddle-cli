module Unfuddle
  module Resources
    class Base < ActiveResource::Base
      self.format = :json
      
      def self.set_account(acc)
        self.site = acc.url + "/api/v1"
        self.user = acc.user
        self.password = acc.password
      end
    end
  
    class Repository < Base
      # Get repository changesets
      def changesets
        Changeset.find(:all, :from => "/repositories/#{self.id}/changesets")
      end
      
      # Find repository by abbreviation
      def self.find_by_abbr(value)
        r = Repository.all.select { |r| r.abbreviation == value }
        r.empty? ? nil : r.first
      end
    end
    
    class Changeset < Base ; end
    
    class Project < Base ; end
    
    class Account < Base
      # Get primary account
      def self.primary
        find(:one, :from => '/account')
      end
    end
    
    class Person < Base
      def name
        "#{self.first_name} #{self.last_name}".strip
      end
    end
  end
end
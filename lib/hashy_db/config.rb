module Mince
  module HashyDb # :nodoc:
    # = HashyDb Config
    #
    # HashyDb Config specifies the configuration settings for HashyDb
    #
    # @author Matt Simpson
    module Config
      # Returns the primary key identifier for records.  This is necessary because not all databases use the same
      # primary key.
      #
      # @return [Symbol] the name of the primary key field.
      def self.primary_key
        :id
      end
    end
  end
end

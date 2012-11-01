module Mince # :nodoc:
  module HashyDb # :nodoc:
    # = HashyDb Version
    #
    # HashyDb Version specifies the version of this library
    #
    # Use these versions to negotiate with for compatibility
    #
    # Major version releases indicates a major enhancement, breaks backward compatibility
    # Minor version release indicates an addition, enhancement or bug fix which is not an immediate need, does not break backward compatibility
    # Patch version release indicates a bug fix or patch that is an emergency, does not break backward compatibility
    #
    # @author Matt Simpson
    module Version

      # Provides the major level version of the library
      def self.major
        2
      end

      # Provides the minor level version of the library
      def self.minor
        0
      end

      # Provides the patch level version of the library
      def self.patch
        '0.pre.2'
      end
    end

    # Provides the full version of the library
    def self.version
      [Version.major, Version.minor, Version.patch].join(".")
    end
  end
end

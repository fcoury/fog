module Webbynode
  class << self
    if Fog.credentials[:webbynode_api_key] && Fog.credentials[:webbynode_username]

      def initialized?
        true
      end

      def [](service)
        @@connections ||= Hash.new do |hash, key|
          credentials = Fog.credentials.reject do |k,v|
            ![:webbynode_api_key, :webbynode_username].include?(k)
          end
          hash[key] = case key
          when :webbies
            Fog::Webbynode.new(credentials)
          end
        end
        @@connections[service]
      end

      def directories
        self[:files].directories
      end

      def flavors
        self[:servers].flavors
      end

      def images
        self[:servers].images
      end

      def servers
        self[:servers].servers
      end
      
    else

      def initialized?
        false
      end

    end
  end
end
require 'fog/collection'
require 'fog/slicehost/models/server'

module Fog
  module Webbynode

    class Mock
      def servers
        Fog::Webbynode::Servers.new(:connection => self)
      end
    end

    class Real
      def servers
        Fog::Webbynode::Servers.new(:connection => self)
      end
    end

    class Servers < Fog::Collection

      model Fog::Webbynode::Server

      def all
        data = connection.get_webbies.body['webbies']
        load(data)
      end

      def get(server_id)
        if server_id && server = connection.get_webby(server_id).body
          new(server)
        elsif !server_id
          nil
        end
      rescue Excon::Errors::Forbidden
        nil
      end

    end

  end
end

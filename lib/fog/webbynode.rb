module Fog
  module Webbynode

    def self.new(options={})

      unless @required
        # require 'fog/webbynode/models/flavor'
        # require 'fog/webbynode/models/flavors'
        require 'fog/webbynode/models/job'
        require 'fog/webbynode/models/image'
        require 'fog/webbynode/models/images'
        require 'fog/webbynode/models/server'
        require 'fog/webbynode/models/servers'
        require 'fog/webbynode/requests/create_webby'
        require 'fog/webbynode/requests/delete_webby'
        require 'fog/webbynode/requests/get_flavor'
        require 'fog/webbynode/requests/get_flavors'
        require 'fog/webbynode/requests/get_image'
        require 'fog/webbynode/requests/get_images'
        require 'fog/webbynode/requests/get_webby'
        require 'fog/webbynode/requests/get_webbies'
        require 'fog/webbynode/requests/reboot_webby'
        @required = true
      end

      unless @webbynode_email = options[:webbynode_email]
        raise ArgumentError.new('webbynode_email is required to access webbynode')
      end
      unless @webbynode_token = options[:webbynode_token]
        raise ArgumentError.new('webbynode_token is required to access webbynode')
      end

      if Fog.mocking?
        Fog::Webbynode::Mock.new(options)
      else
        Fog::Webbynode::Real.new(options)
      end
    end

    def self.reset_data(keys=Mock.data.keys)
      Mock.reset_data(keys)
    end

    class Mock

      def self.data
        @data ||= Hash.new do |hash, key|
          hash[key] = {}
        end
      end

      def self.reset_data(keys=data.keys)
        for key in [*keys]
          data.delete(key)
        end
      end

      def initialize(options={})
      end

    end

    class Real

      def initialize(options={})
        @webbynode_email = options[:webbynode_email]
        @webbynode_token = options[:webbynode_token]
        
        # @webbynode_password = options[:webbynode_password]
        # @host   = options[:host]    || "manager.webbynode.com"
        # @port   = options[:port]    || 443
        # @scheme = options[:scheme]  || 'https'
        @host   = options[:host]    || "stage.mywebby.info"
        @port   = options[:port]    || 80
        @scheme = options[:scheme]  || 'http'
        @path   = options[:path]    || 'api/xml'
      end

      def request(params)
        @connection = Fog::Connection.new("#{@scheme}://#{@host}:#{@port}/#{@path}/#{params[:path]}")
        headers = {}
        # case params[:method]
        # when 'DELETE', 'GET', 'HEAD'
        #   headers['Accept'] = 'application/xml'
        # when 'POST', 'PUT'
        #   # headers['Content-Type'] = 'application/xml'
        # end

        response = @connection.request({
          :email    => @webbynode_email,
          :token    => @webbynode_token,
          :body     => "email=#{@webbynode_email}&token=#{@webbynode_token}", 
          :expects  => params[:expects],
          :headers  => headers.merge!(params[:headers] || {}),
          :host     => @host,
          :method   => params[:method],
          :parser   => params[:parser]# ,
          #           :path     => params[:path]
        })

        response
      end

    end
  end
end

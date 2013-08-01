require 'rack/request'
require 'active_support/hash_with_indifferent_access'

module SiliconRewriter
  class Rewriter
    attr_accessor :application, :rules

    def initialize(application, options)
      self.application = application
      self.rules       = options[:rules]

      raise "'rules' option is required" if self.rules.nil?
    end

    def call(env)
      if (rule = matching_rule(env))
        env['REQUEST_URI']  = rule[:to]
        env['PATH_INFO']    = rule[:to]
        env['QUERY_STRING'] = ''
      end

      self.application.call(env)
    end

    private

    def matching_rule(env)
      request = ::Rack::Request.new(env)

      self.rules.each do |rule|
        rule = HashWithIndifferentAccess.new(rule)

        if rule[:host] == request.host && rule[:from] == request.path_info
          return rule
        end
      end

      nil
    end
  end
end

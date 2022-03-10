class ApiConstraints
    def initialize(options)
      @version = options[:version]
      @default = options[:default]
    end

    def matches?(req)
      @default || req.headers["Accept"].include?("application/vnd.<app_name>.v#{@version}")
    end
end
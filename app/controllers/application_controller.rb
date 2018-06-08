class ApplicationController < ActionController::Base
    def page_title
        @pg_title ||= "Haxxor News"
    end
    
    helper_method :page_title
end

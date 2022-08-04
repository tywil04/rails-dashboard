class PagesController < ApplicationController
    before_action :authenticate_user!

    def index 
        @stacks = Stack.where(user: current_user)
        render "index"
    end
end

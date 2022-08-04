class LinksController < ApplicationController
    def create 
        @stack = Stack.find_by(title: params[:stack], user: current_user)
        @link = Link.create(displayname: params[:link][:displayname], url: params[:link][:url], stack: @stack)
    end

    def delete 
        @stack = Stack.find_by(user: current_user, title: params[:stack])
        Link.find_by(stack: @stack, displayname: params[:link][:displayname]).destroy
    end
end

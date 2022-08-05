class LinksController < ApplicationController
    def create 
        @link = Link.create(displayname: params[:link][:displayname], url: params[:link][:url], stack: get_stack)
    end

    def delete 
        get_link.destroy
    end

    def rename 
        get_link.update(displayname: params[:newdisplayname])
    end

    def relink 
        get_link.update(url: params[:newurl])
    end

    private 

    def get_stack 
        stack = Stack.find_by(user: current_user, title: params[:stack])
    end

    def get_link 
        link = Link.find_by(stack: get_stack, displayname: params[:link][:displayname])
    end
end

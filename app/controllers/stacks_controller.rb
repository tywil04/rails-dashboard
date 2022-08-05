class StacksController < ApplicationController
    def create 
        @stack = Stack.create(user: current_user, title: params[:stack][:title], position: Stack.where(user: current_user).length + 1)
    end

    def delete 
        @stack = Stack.find_by(user: current_user, title: params[:stack][:title])
        Link.where(stack: @stack).destroy_all
        @stack.destroy
    end

    def rename 
        @stack = Stack.find_by(user: current_user, title: params[:stack][:title])
        @stack.update(title: params[:newtitle])
    end
end

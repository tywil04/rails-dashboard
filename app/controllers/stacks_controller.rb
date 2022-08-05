class StacksController < ApplicationController
    def create 
        @stack = Stack.create(user: current_user, title: params[:stack][:title], position: Stack.where(user: current_user).length + 1)
    end

    def delete 
        @stack = get_stack
        Link.where(stack: @stack).destroy_all
        @stack.destroy
    end

    def rename 
        get_stack.update(title: params[:newtitle])
    end

    private 

    def get_stack 
        @stack = Stack.find_by(user: current_user, title: params[:stack][:title])
    end
end

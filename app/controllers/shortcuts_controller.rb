class ShortcutsController < ApplicationController
    def create 
        rid = Spicy::Proton.pair
        while Shortcut.find_by(rid: rid) 
            rid = Spicy::Proton.pair
        end

        @shortcut = Shortcut.create(user: current_user, rid: rid, url: params[:shortcut][:url], private: params[:shortcut][:private])

        respond_to do |format| 
            format.json { render json: { rid: @shortcut.rid } }
        end
    end

    def show 
        @shortcut = Shortcut.find_by(rid: params[:rid])

        if (@shortcut.user == current_user and @shortcut.private) or (@shortcut.private == false)
            redirect_to @shortcut.url, allow_other_host: true
        else 
            redirect_to root_path
        end
    end

    def delete 
        Shortcut.find_by(rid: params[:rid]).destroy
    end
end

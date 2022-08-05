import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["newstack", "backdrop"]

    connect() {
        this.newstackTarget.onclose = this.closeall
    }

    opennewstack = () => this.opendialog(this.newstackTarget)

    opendialog( dialog) {
        this.backdropTarget.classList.remove("hidden");
        dialog.showModal();
        dialog.classList.remove("hidden");
    }

    closedialog(dialog) {
        this.backdropTarget.classList.add("hidden");
        dialog.open = false;
        dialog.classList.add("hidden");
    }

    closeall() {
        this.closedialog(this.newstackTarget)
    }
}
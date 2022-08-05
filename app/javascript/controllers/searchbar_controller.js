import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["input"];

    connect() {
        this.inputTarget.onkeypress = event => {
            if (event.key === "Enter" && this.inputTarget.value.trim() != "") {
                const query = this.inputTarget.value.trim();

                window.location = `https://duckduckgo.com/?q=${encodeURIComponent(query)}`;

                this.inputTarget.value = "";
            }
        }
    }

    disconnect() {
        this.inputTarget.onkeypress = undefined;
    }
}
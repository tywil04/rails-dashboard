import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["input"];

    connect() {
        this.inputTarget.onkeypress = event => {
            if (event.key === "Enter" && this.inputTarget.value.trim() != "") {
                const query = this.inputTarget.value.trim();

                if (query.substring(0, 1) === ">") {
                    this.command(query);
                } else {
                    this.ddg(query);
                }

                this.inputTarget.value = "";
            }
        }
    }

    disconnect() {
        this.inputTarget.onkeypress = undefined;
    }

    ddg(query) {
        window.location = `https://duckduckgo.com/?q=${encodeURIComponent(query)}`;
    }

    command(query) {
        query = query.substring(1);

        let tokens = query.match(/[^\s"']+|"([^"]*)"/gmi).map(token => {
            if (token.substring(0, 1) === '"' && token.substring(token.length - 1, token.length) === '"') {
                return token.substring(1, token.length - 1)
            } else {
                return token.trim()
            }
        });

        if ( this.isIn(tokens[0], ["new", "create"]) ) {
            if (tokens[1] === "stack") {
                this.request("/stacks", "POST", {
                    title: tokens[2],
                }) 
            } else if (tokens[1] === "link") {
                this.request("/links", "POST", {
                    stack: tokens[2],
                    displayname: tokens[3],
                    url: tokens[4],
                })
            } else if (tokens[1] === "shortcut") {
                if (!tokens[2].startsWith("https://") && !tokens[2].startsWith("http://") && !tokens[2].startsWith("/")) {
                    return;
                }

                tokens[3] = tokens[3] === undefined ? true: tokens[3].toLowerCase() === "public" ? false: true;

                this.request("/shortcuts", "POST", {
                    url: tokens[2],
                    private: tokens[3],
                }).then(response => response.json().then(rid => {
                    console.log(rid)
                }))
            }
        } else if ( this.isIn(tokens[0], ["delete", "remove"]) ) {
            if (tokens[1] === "stack") {
                this.request("/stacks", "DELETE", {
                    title: tokens[2],
                }) 
            } else if (tokens[1] === "link") {
                this.request("/links", "DELETE", {
                    stack: tokens[2],
                    displayname: tokens[3],
                })
            } else if (tokens[1] === "shortcut") {
                this.request("/shortcuts", "DELETE", {
                    rid: tokens[2],
                })
            }   
        } else if ( this.isIn(tokens[0], ["rename", "retitle"]) ) {
            if (tokens[1] === "stack") {
                this.request("/stacks", "PUT", {
                    title: tokens[2],
                    newtitle: tokens[3],
                }) 
            } else if (tokens[1] === "link") {
                this.request("/links", "PUT", {
                    stack: tokens[2],
                    displayname: tokens[3],
                    newdisplayname: tokens[4],
                })
            }       
        } else if ( this.isIn(tokens[0], ["relink", "reurl"]) ) {
            this.request("/links", "PATCH", {
                stack: tokens[1],
                displayname: tokens[2],
                newurl: tokens[3],
            })      
        }
    }

    request(url, method, body) {
        body["authenticity_token"] = document.querySelector("meta[name=csrf-token]").content

        return fetch(url, {
            method: method.toUpperCase(),
            body: JSON.stringify(body),
            headers: {
                "Content-Type": "application/json",
            }
        })          
    }

    isIn(value1, array1) {
        return array1.indexOf(value1) > -1;
    }
}
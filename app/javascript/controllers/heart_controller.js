import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="heart"
export default class extends Controller {
static targets = ["icon"]

  connect() {
    console.log("hellooo");
  }

  favorite(event) {
    // event.preventDefault()
    console.log("are you there?");
    // console.log(this.iconTarget.parentElement.href);


    // fetch(this.iconTarget.parentElement.href, {
    //   method: "POST",
    //   headers: { "Accept": "application/json" },
    //   body: this.iconTarget
    // })
    //   .then(response => response.json())
    //   .then((data) => {
    //     console.log(data)
    //   })
  }

  unfavorite() {}
}

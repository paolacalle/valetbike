import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  open() {
    this.modalTarget.showModal();
    // document.body.classList.add("overflow-hidden");
  }

  clickOutside(event){
    if (event.Target === this.modalTarget) {
      this.modalTarget.close()
    }
  }

}
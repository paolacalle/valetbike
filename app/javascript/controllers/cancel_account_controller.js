// import { Controller } from "@hotwired/stimulus"

// export default class extends Controller {
//   static targets = ["modal"]

//   openModal(event) {
//     event.preventDefault();
//     this.modalTarget.style.display = "block";
//   }

//   closeModal() {
//     this.modalTarget.style.display = "none";
//   }

//   confirmCancellation() {
//     const userInput = prompt('Please type "CANCEL" to confirm account deletion.');
//     if (userInput === 'CANCEL') {
//       // Submit the form or send a delete request
//       // Replace 'formSelector' with your form's selector
//       document.querySelector('formSelector').submit();
//     } else {
//       this.closeModal();
//     }
//   }
// }

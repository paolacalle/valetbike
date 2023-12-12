import { Controller } from "@hotwired/stimulus"
// Makes it harder for user to cancel account 

// Connects to data-controller="confirmation"
export default class extends Controller {
  confirm(event) {
    event.preventDefault();

    if (!confirm('Are you 100% sure you want to cancel your account? This action cannot be undone!')) {
      return;
    }

    var userInput = prompt('Please type "BYE VALETBIKE" to confirm account deletion.');
    if (userInput === 'BYE VALETBIKE') {
      event.target.closest('form').submit();
    } else {
      alert('Account deletion canceled.');
    }
  }
}

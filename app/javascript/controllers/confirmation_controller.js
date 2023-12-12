import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="confirmation"
export default class extends Controller {
  confirm(event) {
    event.preventDefault();

    if (!confirm('Are you absolutely sure you want to cancel your account? This action cannot be undone.')) {
      return;
    }

    var userInput = prompt('Please type "CANCEL" to confirm account deletion.');
    if (userInput === 'CANCEL') {
      event.target.closest('form').submit();
    } else {
      alert('Account deletion canceled.');
    }
  }
}

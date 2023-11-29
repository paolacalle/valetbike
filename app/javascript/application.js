// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
//map
import "mapkick/bundle"


document.addEventListener('DOMContentLoaded', () => {
  const returnButton = document.getElementById('return-rental-button');
  const popupModal = document.getElementById('popup-modal');
  const cancelReturn = document.getElementById('cancel-return');

  returnButton.addEventListener('click', (e) => {
    e.preventDefault();
    popupModal.classList.remove('hidden');
  });

  cancelReturn.addEventListener('click', () => {
    popupModal.classList.add('hidden');
  });
});


  

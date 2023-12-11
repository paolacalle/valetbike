import { Controller } from "@hotwired/stimulus"

const options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0
};

// Connects to data-controller="geolocation"
export default class extends Controller {

  success(pos) {
    const crd = pos.coords;
    const latitude = crd.latitude;
    const longitude = crd.longitude;
    const currentURL = window.location.href;
    const distance = document.getElementById("distance").value;

    const updatedURL = new URL(currentURL);

    console.log('Your current position is:');
    console.log(`Latitude : ${crd.latitude}`);
    console.log(`Longitude: ${crd.longitude}`);
    console.log(`More or less ${crd.accuracy} meters.`);
    
    // Send coordinates to rails server
    fetch('/geolocation/save_coordinates', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ latitude: latitude, longitude: longitude })
    }).then(response => {
      if (response.ok) {
        console.log('Coordinates saved');
      } else {
        console.error('Failed to save coordinates');
      }
    }).catch(error => {
      console.error('Error while saving coordinates:', error);
    });
    
    updatedURL.searchParams.set('search_nearest', 1);
    updatedURL.searchParams.set('lat', latitude);
    updatedURL.searchParams.set('long', longitude);
    updatedURL.searchParams.set('dist', distance);
    location.assign(updatedURL);
  }

  search() {
    navigator.geolocation.getCurrentPosition(this.success, this.error, options);
  }


}
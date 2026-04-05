import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("CIDA: Custom Confirmation Controller Connected ✅");

    const turboObj = window.Turbo || (typeof Turbo !== 'undefined' ? Turbo : null);

    if (turboObj) {
      turboObj.setConfirmMethod((message, element) => {
        return this.showCustomModal(message);
      })
    }
  }

  showCustomModal(message) {
    let modal = document.getElementById('turbo-confirm-modal');
    let messageElement = document.getElementById('modal-message');
    let confirmButton = document.getElementById('modal-confirm');
    let cancelButton = document.getElementById('modal-cancel');
    let closeButton = document.getElementById('modal-close');

    if (!modal) return Promise.resolve(true);

    messageElement.innerText = message;
    modal.classList.remove('hidden');

    return new Promise((resolve) => {
      const resetModal = () => {
        modal.classList.add('hidden');
        confirmButton.removeEventListener('click', onConfirm);
        cancelButton.removeEventListener('click', onCancel);
        closeButton.removeEventListener('click', onCancel);
        modal.removeEventListener('click', onOverlayClick);
      };

      const onConfirm = () => {
        resetModal();
        resolve(true); 
      };

      const onCancel = () => {
        resetModal();
        resolve(false); 
      };

      const onOverlayClick = (e) => {
        // Only cancel if clicking exactly on the overlay, not the card
        if (e.target === modal) {
          onCancel();
        }
      };

      confirmButton.addEventListener('click', onConfirm);
      cancelButton.addEventListener('click', onCancel);
      closeButton.addEventListener('click', onCancel);
      modal.addEventListener('click', onOverlayClick);
    });
  }
}

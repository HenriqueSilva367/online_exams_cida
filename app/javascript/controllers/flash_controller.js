import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    // Auto-hide after 5 seconds
    this.timeout = setTimeout(() => {
      this.close()
    }, 5000)
  }

  close() {
    this.element.classList.add("animate-out", "slide-out-to-right", "fade-out")
    
    // Wait for animation to finish before removing
    setTimeout(() => {
      this.element.remove()
    }, 300)
  }

  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
  }
}

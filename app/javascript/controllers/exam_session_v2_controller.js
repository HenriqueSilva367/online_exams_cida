import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "question", "navButton", "timerDisplay", "subjectProgress", "autoNext", "lightbox", "lightboxImage" ]
  static values = { 
    startTime: String, 
    duration: Number,
    currentIndex: Number
  }

  connect() {
    this.startTimer()
    this.showQuestion(0)
    this.updateProgress()
    this.restoreNavButtons()
  }

  // Restore navigator colors on load
  restoreNavButtons() {
    this.questionTargets.forEach((q, index) => {
      const inputs = q.querySelectorAll('input[type="radio"]')
      const isAnswered = Array.from(inputs).some(input => input.checked)
      if (isAnswered) {
        this.navButtonTargets[index].classList.add("nav-answered")
      }
    })
  }

  // Real Zoom (Lightbox)
  enlarge(event) {
    const img = event.currentTarget
    this.lightboxImageTarget.src = img.src
    this.lightboxTarget.showModal()
  }

  // Question Navigation
  showQuestion(index) {
    this.questionTargets.forEach((el, i) => {
      el.style.display = i === index ? "block" : "none"
    })
    
    // Update Navigator Buttons Status (Active/Inactive)
    this.navButtonTargets.forEach((el, i) => {
      el.classList.toggle("nav-active", i === index)
      // If it has a radio selected, mark as answered
      const answered = this.questionTargets[i].querySelector('input[type="radio"]:checked')
      el.classList.toggle("nav-answered", !!answered)
    })

    this.currentIndexValue = index
  }

  goTo(event) {
    const index = parseInt(event.currentTarget.dataset.index)
    this.showQuestion(index)
  }

  next() {
    if (this.currentIndexValue < this.questionTargets.length - 1) {
      this.showQuestion(this.currentIndexValue + 1)
    }
  }

  previous() {
    if (this.currentIndexValue > 0) {
      this.showQuestion(this.currentIndexValue - 1)
    }
  }

  // Selection Logic
  selectOption(event) {
    const questionIndex = this.currentIndexValue
    const navBtn = this.navButtonTargets[questionIndex]
    navBtn.classList.add("nav-answered")
    
    this.updateProgress()
    this.autoSave()

    // Auto-next logic
    if (this.hasAutoNextTarget && this.autoNextTarget.checked) {
      setTimeout(() => this.next(), 400)
    }
  }

  autoSave() {
    const form = document.getElementById("exam-form")
    const formData = new FormData(form)
    
    fetch(form.action, {
      method: "PATCH",
      body: formData,
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "text/vnd.turbo-stream.html"
      }
    }).then(response => {
      console.log("Progresso salvo automaticamente ✅")
    })
  }

  // Progress logic per subject
  updateProgress() {
    // We'll calculate progress for each subject in the sidebar
    // This assumes we have subject containers with data-subject-id
    const subjects = {}
    
    this.questionTargets.forEach((q) => {
      const subjectId = q.dataset.subjectId
      if (!subjects[subjectId]) subjects[subjectId] = { answered: 0, total: 0 }
      subjects[subjectId].total++
      if (q.querySelector('input[type="radio"]:checked')) {
        subjects[subjectId].answered++
      }
    })

    // Update progress bars in DOM
    this.subjectProgressTargets.forEach((progressEl) => {
      const sid = progressEl.dataset.subjectId
      if (subjects[sid]) {
        const pct = (subjects[sid].answered / subjects[sid].total) * 100
        progressEl.style.width = `${pct}%`
        // Update general simulation progress if needed
      }
    })
  }

  // Timer logic
  startTimer() {
    const end = new Date(this.startTimeValue).getTime() + (this.durationValue * 60 * 1000)
    
    this.timerInterval = setInterval(() => {
      const now = new Date().getTime()
      const distance = end - now

      if (distance <= 0) {
        clearInterval(this.timerInterval)
        this.timerDisplayTarget.innerHTML = "00:00:00"
        this.timerDisplayTarget.style.color = "red"
        // Auto-submit would be here
      } else {
        const hours = Math.floor(distance / (1000 * 60 * 60))
        const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60))
        const seconds = Math.floor((distance % (1000 * 60)) / 1000)
        
        this.timerDisplayTarget.innerHTML = 
          `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`
      }
    }, 1000)
  }

  disconnect() {
    if (this.timerInterval) clearInterval(this.timerInterval)
  }
}

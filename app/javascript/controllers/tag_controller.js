import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "container", "input" ]

  connect() {
    this.initializeTags()
  }

  initializeTags() {
    this.inputTarget.value.split(',').forEach(tag => {
      if (tag.trim() !== '') {
        this.addTag(tag.trim())
      }
    })
    this.inputTarget.value = ''
  }

  addTag(event) {
    if (event.key === 'Enter' && this.inputTarget.value.trim() !== '') {
      event.preventDefault()
      this.createTagBadge(this.inputTarget.value.trim())
      this.inputTarget.value = ''
      this.updateTagList()
    }
  }

  removeTag(event) {
    event.target.closest('.badge').remove()
    this.updateTagList()
  }

  createTagBadge(tagName) {
    const badge = document.createElement('span')
    badge.className = 'badge bg-primary me-1 mb-1'
    badge.innerHTML = `
      ${tagName}
      <button type="button" class="btn-close btn-close-white" data-action="click->tag#removeTag" aria-label="Remove tag"></button>
    `
    this.containerTarget.appendChild(badge)
  }

  updateTagList() {
    const tags = Array.from(this.containerTarget.children).map(badge => badge.textContent.trim())
    this.inputTarget.value = tags.join(', ')
  }
}
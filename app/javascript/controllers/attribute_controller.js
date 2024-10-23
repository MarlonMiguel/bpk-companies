// app/javascript/controllers/attribute_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["availableAttributes", "categoryAttributes"]

  addAttribute() {
    this.moveItems(this.availableAttributesTarget, this.categoryAttributesTarget)
  }

  removeAttribute() {
    this.moveItems(this.categoryAttributesTarget, this.availableAttributesTarget)
  }

  moveItems(fromList, toList) {
    Array.from(fromList.selectedOptions).forEach(option => {
      toList.appendChild(option)
    })
  }

  beforeSubmit() {
    // Marcar todos os itens em "categoryAttributes" como selecionados
    Array.from(this.categoryAttributesTarget.options).forEach(option => {
      option.selected = true
    })

    // Remover seleção dos itens em "availableAttributes" para não enviar desnecessariamente
    Array.from(this.availableAttributesTarget.options).forEach(option => {
      option.selected = false
    })
  }
}

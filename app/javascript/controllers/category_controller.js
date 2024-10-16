import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["availableCategories", "selectedCategories"]

  addCategory() {
    this.moveItems(this.availableCategoriesTarget, this.selectedCategoriesTarget)
  }

  removeCategory() {
    this.moveItems(this.selectedCategoriesTarget, this.availableCategoriesTarget)
  }

  moveItems(fromList, toList) {
    Array.from(fromList.selectedOptions).forEach(option => {
      toList.appendChild(option)
    })
  }

  beforeSubmit() {
    // Marcar todas as categorias em "selectedCategories" como selecionadas
    Array.from(this.selectedCategoriesTarget.options).forEach(option => {
      option.selected = true
    })

    // Remover a seleção das categorias em "availableCategories" para não enviar desnecessariamente
    Array.from(this.availableCategoriesTarget.options).forEach(option => {
      option.selected = false
    })
  }
}
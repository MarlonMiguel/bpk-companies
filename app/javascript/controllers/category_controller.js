import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["availableCategories", "selectedCategories", "attributesContainer"]
  

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

  // fetchAttributes(event) {
  //   const categoryId = event.target.value;
  //   console.log('entrou no fetch');  // Verifica se o método está sendo chamado
  //   console.log(`/categories/${categoryId}/attributes`);  // Verifica se a URL está correta
  
  //   if (categoryId) {
  //     fetch(`/categories/${categoryId}/attributes`)
  //       .then(response => {
  //         if (!response.ok) {  // Adiciona verificação de erros de resposta
  //           throw new Error('Network response was not ok');
  //         }
  //         return response.json();
  //       })
  //       .then(data => this.renderAttributes(data))
  //       .catch(error => console.error('Error:', error));
  //   } else {
  //     this.attributesContainerTarget.innerHTML = "";
  //   }
  // }

  // renderAttributes(attributes) {
  //   console.log('entrou no render');
  //   console.log(attributes); // Verifique a estrutura dos atributos
  
  //   this.attributesContainerTarget.innerHTML = attributes.map(attribute => {
  //     return `
  //       <div class="form-group">
  //         <label>${attribute.description}</label>
  //         <input type="${attribute.type === 'N' ? 'number' : 'text'}" name="attribute_values[${attribute.id}]" class="form-control" />
  //       </div>
  //     `;
  //   }).join("");
  // }
}
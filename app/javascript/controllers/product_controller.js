// Exemplo de ProductController
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["mainImage", "zoomedImage", "imageModal"];

    fetchAttributes(event) {
        const categoryId = event.target.value;

        if (categoryId) {
            this.getAttributes(categoryId);
        }
    }

    async getAttributes(categoryId) {
        try {
            const response = await fetch(`/categories/${categoryId}/attributes`);
            const attributes = await response.json();
            this.renderAttributes(attributes);
        } catch (error) {
            console.error("Erro ao buscar atributos:", error);
        }
    }

    renderAttributes(attributes) {
        const attributesContainer = document.getElementById("attributesContainer");

        attributesContainer.innerHTML = '';

        attributes.forEach(attribute => {
            const div = document.createElement('div');
            div.classList.add('mb-3');

            div.innerHTML = `
                <label for="attribute_${attribute.id}" class="form-label">${attribute.description}</label>
                <input type="text" id="attribute_${attribute.id}" name="product[attributes][${attribute.id}]" class="form-control" />
            `;

            attributesContainer.appendChild(div);
        });

    }

    changeMainImage(event) {
        const newSrc = event.currentTarget.querySelector('img').src;
        this.mainImageTarget.src = newSrc;
        this.zoomedImageTarget.src = newSrc;
    }

    openModal() {
        this.imageModalTarget.style.display = 'block';
    }

    closeModal() {
        this.imageModalTarget.style.display = 'none';
    }
}
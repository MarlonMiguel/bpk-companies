// app/javascript/controllers/carousel_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Inicializa o carrossel do Bootstrap
    this.carousel = new bootstrap.Carousel(this.element, {
      interval: 1000, // Tempo de exibição de cada slide em milissegundos
      touch: false // Desabilita o toque para navegação
    });

    // Inicia a mudança automática de slides
    this.startAutoSlide();
  }

  startAutoSlide() {
    setInterval(() => {
      console.log('acessou');
      this.carousel.next(); // Avança para o próximo slide
    }, 3000); // Define o intervalo de tempo
  }

  disconnect() {
    // Para o carrossel ao desconectar o controlador
    this.carousel.dispose();
  }
}
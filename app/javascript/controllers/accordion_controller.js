import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["submenu"]
  
    connect() {
      // Inicializa o controlador
    }
  
    toggle(event) {
      event.preventDefault()
      const link = event.currentTarget
      const closestLi = link.closest("li")
      const isActive = closestLi.classList.contains("active")
  
      // Fecha todos os submenus visíveis
      this.submenuTargets.forEach((submenu) => {
        submenu.style.display = "none"
        submenu.closest("li").classList.remove("active")
      })
  
      // Se o submenu não estiver ativo, expande-o e o define como ativo
      if (!isActive) {
        const submenu = closestLi.querySelector("ul")
        if (submenu) {
          submenu.style.display = "block"
          closestLi.classList.add("active")
        }
      }
    }
  }
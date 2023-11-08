import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["character", "equipment", "characterSlot", "equipmentSlot","arenaForm"];

  connect() {
    this.isMouseDown = false;
    this.duplicatedElement = null;
    this.lastElementId = null;
    console.log("DragDropController connected");

    document.addEventListener("mousemove", (event) => {
      if (this.isMouseDown && this.duplicatedElement) {
        this.moveDuplicateElement(event);
      }
    });

    document.addEventListener("mouseup", (event) => {
      if (this.isMouseDown && this.duplicatedElement) {
        this.removeDuplicateElement();
      }

      console.log(this.arenaFormTarget);

      this.isMouseDown = false;
    });
  }

  toggleCharacter(event) {
    if (this.isMouseDown) {
      return;
    }

    this.isMouseDown = true;
    this.createDuplicateElement(event, "character");
  }

  toggleEquipment(event) {
    if (this.isMouseDown) {
      return;
    }

    this.isMouseDown = true;
    this.createDuplicateElement(event, "equipment");
  }

  toggleCharacterSlot(event) {
    console.log(event.target)
  }

  createDuplicateElement(event, type) {
    this.duplicatedElement = this.findContainer(event.target, type);
    if (this.duplicatedElement) {
      this.duplicatedElement = this.duplicatedElement.cloneNode(true);
      document.body.appendChild(this.duplicatedElement);
      this.duplicatedElement.style.position = "absolute";
      this.duplicatedElement.style.pointerEvents = "none";
     this.moveDuplicateElement(event)
    }
  }

  moveDuplicateElement(event) {
    if (this.duplicatedElement) {
      const elementWidth = this.duplicatedElement.offsetWidth;
      const elementHeight = this.duplicatedElement.offsetHeight;
      const mouseX = event.clientX;
      const mouseY = event.clientY;

      const left = mouseX - elementWidth / 2;
      const top = mouseY - elementHeight / 2;

      this.duplicatedElement.style.left = left + "px";
      this.duplicatedElement.style.top = top + "px";
    }
  }

  removeDuplicateElement() {
    if (this.duplicatedElement) {
      this.duplicatedElement.remove();
      this.duplicatedElement = null;
    }
  }

  findContainer(element, type) {
    let searchedClass = "profile-container";
    if (type == "equipment") searchedClass = "equipment-container";
    console.log(element);
    if (element.classList.contains(searchedClass)) return element;

    return this.findContainer(element.parentNode, type);
  }
}

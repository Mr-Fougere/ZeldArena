import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = [
    "character",
    "equipment",
    "characterSlot",
    "equipmentSlot",
    "arenaForm",
  ];

  connect() {
    this.isMouseDown = false;
    this.duplicatedElement = null;
    this.lastElementId = null;
    this.lastElementPosition;
    this.lastElementType = null;

    document.addEventListener("mousemove", (event) => {
      if (this.isMouseDown && this.duplicatedElement) {
        this.moveDuplicateElement(event);
      }
    });

    document.addEventListener("mouseup", (event) => {
      if (this.isMouseDown && this.duplicatedElement) {
        this.removeDuplicateElement();
      }

      let turboFrameSlot = this.findTurboFrame(event.target);
      if (turboFrameSlot) this.updateArenaForm(turboFrameSlot);

      this.lastElementId = null;
      this.lastElementType = null;

      this.isMouseDown = false;
    });
  }

  updateArenaForm(turboFrameSlot) {
    let slot = turboFrameSlot.dataset.slot;
    if (!slot) return;
    let { targetType, targetInput, targetPosition } =
      this.slotInputInformation(slot);

    if (targetType !== this.lastElementType) return;
    if (
      targetType == "equipment" &&
      targetPosition !== this.lastElementPosition
    )
      return;
    if (targetInput.value == this.lastElementId) {
      targetInput.value = "";
      this.updateUI(turboFrameSlot.id, "");
      return;
    }

    targetInput.value = this.lastElementId;

    this.updateUI(turboFrameSlot.id, targetInput.value);

    turboFrameSlot.addEventListener("click", () => {
      targetInput.value = "";
      this.updateUI(turboFrameSlot.id, "");
      this.checkArenaFormValid();
    });

    this.checkArenaFormValid();
  }

  updateUI(turboFrameId, value) {
    Rails.ajax({
      type: "POST",
      url: "/arena/update_ui",
      data: `turbo_frame_id=${turboFrameId}&value=${value}`,
      success: (data) => {
        Turbo.renderStreamMessage(data);
      },
    });
  }

  enableSubmitButton() {
    this.arenaFormTarget.querySelector(".start-battle-button").disabled = false;
  }

  disableSubmitButton() {
    this.arenaFormTarget.querySelector(".start-battle-button").disabled = true;
  }

  slotInputInformation(slot) {
    let targetPosition = slot[1] == "L" ? "left_hand" : "right_hand";
    let targetType = "character";
    let INPUT_ID_ROOT = "battle_battle_characters_attributes_";
    let subInputId = `_character_id`;
    if (slot.length > 1) targetType = "equipment";
    if (targetType == "equipment")
      subInputId = `_battle_character_equipments_attributes_${
        slot[1] == "L" ? 0 : 1
      }_equipment_id`;

    let inputId = `${INPUT_ID_ROOT}${slot[0] - 1}${subInputId}`;
    let targetInput = this.arenaFormTarget.querySelector(`#${inputId}`);

    return { targetType, targetInput, targetPosition };
  }

  checkArenaFormValid() {
    const formElements = this.arenaFormTarget.elements;
    let isValid = true;

    for (let i = 0; i < formElements.length; i++) {
      const element = formElements[i];

      if (element.id.includes("character_id")) {
        if (element.value.trim() === "") {
          isValid = false;
          break;
        }
      }
    }
    if (isValid) {
      this.enableSubmitButton();
    } else {
      this.disableSubmitButton();
    }
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

  createDuplicateElement(event, type) {
    this.duplicatedElement = this.findContainer(event.target, type);
    this.lastElementId = this.duplicatedElement.dataset.id;
    this.lastElementPosition = this.duplicatedElement.dataset.position;
    this.lastElementType = type;
    if (this.duplicatedElement == null) return;
    if (this.duplicatedElement) {
      this.duplicatedElement = this.duplicatedElement.cloneNode(true);
      document.body.appendChild(this.duplicatedElement);
      this.duplicatedElement.style.position = "absolute";
      this.duplicatedElement.style.pointerEvents = "none";
      this.moveDuplicateElement(event);
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
    if (element.tagName == "BODY") return null;
    if (type == "equipment") searchedClass = "equipment-container";
    if (element.classList.contains(searchedClass)) return element;

    return this.findContainer(element.parentNode, type);
  }

  findTurboFrame(element) {
    if (element.tagName == "BODY") return null;
    if (element.tagName == "TURBO-FRAME") return element;

    return this.findTurboFrame(element.parentNode);
  }
}

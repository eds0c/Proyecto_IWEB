const h2Element = document.querySelector("h2");
const form = document.querySelector("form"),
  passField = form.querySelector(".create-password"),
  passInput = passField.querySelector(".password"),
  cPassField = form.querySelector(".confirm-password"),
  cPassInput = cPassField.querySelector(".cPassword");

// Esconder y mostrar contraseña
const eyeIcons = document.querySelectorAll(".show-hide");

eyeIcons.forEach((eyeIcon) => {
  eyeIcon.addEventListener("click", () => {
    const pInput = eyeIcon.parentElement.querySelector("input"); 
    if (pInput.type === "password") {
      eyeIcon.classList.replace("bx-hide", "bx-show");
      return (pInput.type = "text");
    }
    eyeIcon.classList.replace("bx-show", "bx-hide");
    pInput.type = "password";
  });
});

// Validar contraseña
function createPass() {
  const passPattern =
    /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&-])[A-Za-z\d@$!%*?&-]{8,}$/;

  if (!passInput.value.match(passPattern)) {
    return passField.classList.add("invalid"); //contraseñas no coinciden 
  }
  passField.classList.remove("invalid"); //contraseñas coinciden
}

function confirmPass() {
  if (passInput.value !== cPassInput.value || cPassInput.value === "") {
    return cPassField.classList.add("invalid");
  }
  cPassField.classList.remove("invalid");
}

// Se llama la función por el envío del formulario
form.addEventListener("submit", (e) => {
  e.preventDefault(); 
  createPass();
  confirmPass();

  passInput.addEventListener("keyup", createPass);
  cPassInput.addEventListener("keyup", confirmPass);

  if (
    !passField.classList.contains("invalid") &&
    !cPassField.classList.contains("invalid")
  ) {
    h2Element.textContent = "Se ha cambiado su contraseña";
    form.style.display = "none";
    document.getElementById("passwordChangeSuccess").style.display = "block";
  
  }
});
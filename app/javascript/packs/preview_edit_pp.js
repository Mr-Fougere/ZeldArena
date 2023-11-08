const profilePictureUpload = document.getElementById("profile-picture-edit");
const previewImage = document.getElementById("preview-edit-image");

previewImage.addEventListener("click", function () {
  profilePictureUpload.click();
});

profilePictureUpload.addEventListener("change", function () {
  if (profilePictureUpload.files && profilePictureUpload.files[0]) {
    const reader = new FileReader();

    reader.onload = function (e) {
      previewImage.src = e.target.result;
    };

    reader.readAsDataURL(profilePictureUpload.files[0]);
  }
});
